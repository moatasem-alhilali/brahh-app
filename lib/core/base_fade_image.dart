import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BaseFadeImage extends StatelessWidget {
  const BaseFadeImage({
    super.key,
    required this.image,
    this.fit,
    this.height,
    this.width,
  });
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset(
       'assets/placeholder.png',
        fit: fit,
      ),
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      errorWidget: (context, error, stackTrace) {
        return Image.asset(
        'assets/placeholder.png',
          fit: fit,
        );
      },
    );
  }
}
