import 'package:algoocean/model/news_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../utils/app_color.dart';
import '../../widget/custome_image_widget.dart';

class NewsDetailsPage extends StatefulWidget {
  final Articles articlesData;

  const NewsDetailsPage({super.key, required this.articlesData});

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      appBar: AppBar(backgroundColor: AppColor.white),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0.r),
          child: Column(
            children: [
              Text(
                widget.articlesData.title ?? "",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 18.sp,
                  color: AppColor.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
        
              10.verticalSpace,
              Row(
                children: [
                  Text(
                    widget.articlesData.source?.name ?? "",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.grey,
                    ),
                  ),
                  10.horizontalSpace,
        
                  Text(
                    "• ${DateFormat("MMM, dd yyy").format(DateTime.parse(widget.articlesData.publishedAt ?? ""))}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.grey,
                    ),
                  ),
                ],
              ),
        
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    10.verticalSpace,
                    CustomImageWidget(
                      image: widget.articlesData.urlToImage ?? "",
                      width: ScreenUtil().screenWidth,
                      height: 300.r,
                      fit: BoxFit.fill,
                    ),
                    Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: Text(
                        "~${widget.articlesData.author ?? ""}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    Text(
                      widget.articlesData.description ?? "",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.black,
                      ),
                    ),
                    Text(
                      widget.articlesData.content ?? "",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.black,
                      ),
                    ),
                  ],),
                ),
              )
        
            ],
          ),
        ),
      ),
    );
  }
}
