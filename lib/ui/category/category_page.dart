import 'package:algoocean/core/provider/app_provider.dart';
import 'package:algoocean/ui/news/news_page.dart';
import 'package:algoocean/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 10.r,
            vertical: 10.r,
          ),
          child: Consumer<AppProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${provider.getGreeting()},",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Explore today’s top news",

                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20.sp,
                      color: AppColor.black,
                    ),
                  ),
                  15.verticalSpace,
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      padding: EdgeInsets.zero,
                      itemCount: provider.categoryList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            AppProvider provider = Provider.of<AppProvider>(context, listen: false);
                            provider.resetPagination();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsPage(
                                  title: provider.categoryList[index].title,
                                  selectedCategory:
                                      provider.categoryList[index].keyword,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(5).r,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadiusGeometry.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20).r,
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteShade,
                                    borderRadius: BorderRadiusGeometry.circular(
                                      100,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      100,
                                    ),
                                    child: Image.asset(
                                      provider.categoryList[index].image,
                                      width: 60.r,
                                      height: 60.r,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    provider.categoryList[index].title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: 14.sp,
                                          color: AppColor.black,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
