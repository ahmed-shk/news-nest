import 'package:algoocean/core/provider/app_provider.dart';
import 'package:algoocean/ui/news/news_details_page.dart';
import 'package:algoocean/ui/search/search_page.dart';
import 'package:algoocean/widget/custome_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/news_response.dart';
import '../../utils/app_color.dart';

class NewsPage extends StatefulWidget {
  final String title;
  final String selectedCategory;

  const NewsPage({
    super.key,
    required this.title,
    required this.selectedCategory,
  });

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppProvider provider = Provider.of<AppProvider>(context, listen: false);
      provider.fetchNewsByCategory1(widget.selectedCategory);

      _controller.addListener(() {
        if (_controller.position.pixels >=
            _controller.position.maxScrollExtent - 300) {
          provider.fetchNewsByCategory1(widget.selectedCategory);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 14.sp,
            color: AppColor.black,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            AppProvider provider = Provider.of<AppProvider>(
              context,
              listen: false,
            );
            provider.resetPagination();
            await provider.fetchNewsByCategory1(widget.selectedCategory);
          },
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 10.r),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 10.r),
                  child: TextFormField(
                    onTap: () {
                      Provider.of<AppProvider>(
                        context,
                        listen: false,
                      ).resetSearchPagination();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      hint: Text(
                        "Search..",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.grey,
                        ),
                      ),
                      fillColor: AppColor.white,
                      filled: true,
                    ),
                  ),
                ),

                10.verticalSpace,
                Expanded(
                  child: Consumer<AppProvider>(
                    builder: (context, provider, child) {
                      if (provider.newsResponse == null && provider.isLoading) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (provider.newsResponse != null &&
                          provider.newsResponse?.articles != null &&
                          (provider.newsResponse?.articles?.isNotEmpty ??
                              false)) {
                        return ListView.separated(
                          controller: _controller,
                          itemCount:
                              (provider.newsResponse?.articles?.length ?? 0) +
                              (provider.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index <
                                (provider.newsResponse!.articles?.length ??
                                    0)) {
                              Articles data =
                                  provider.newsResponse!.articles![index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetailsPage(articlesData: data),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: 10.r,
                                  ),
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    children: [
                                      CustomImageWidget(
                                        image: data.urlToImage ?? "",
                                        width: 100.r,
                                        height: 100.r,
                                      ),
                                      10.horizontalSpace,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.title ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontSize: 14.sp,
                                                    color: AppColor.black,
                                                  ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data.source?.name ?? "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                          fontSize: 12.sp,
                                                          color: AppColor.grey,
                                                        ),
                                                  ),
                                                ),

                                                Text(
                                                  "• ${DateFormat("MMM, dd yyy").format(DateTime.parse(data.publishedAt ?? ""))}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontSize: 12.sp,
                                                        color: AppColor.grey,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                          separatorBuilder: (context, index) => ColoredBox(
                            color: AppColor.white,
                            child: Divider(height: 20),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "No Data Found",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.black,
                                ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
