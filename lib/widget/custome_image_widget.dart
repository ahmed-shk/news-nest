import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CustomImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const CustomImageWidget({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Icon(Icons.image,size: 25,),
      imageUrl: image, fit: BoxFit.cover,
      height: height,width: width,
      errorWidget: (c, o, s) => Icon(Icons.image,size: 25,),

    );
  }
}