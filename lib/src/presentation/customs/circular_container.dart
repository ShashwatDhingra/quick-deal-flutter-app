import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/customs/shrimmer.dart';

import '../../core/utils/ui_utils/constants/colors.dart';
import '../../core/utils/ui_utils/constants/sizes.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.padding = Sizes.sm,
    this.bgColor,
    this.overlayColor,
    this.isNetworkImage = false,
    required this.image,
    this.fit = BoxFit.cover,
  });

  final double width, height, padding;
  final Color? bgColor;
  final Color? overlayColor;
  final bool isNetworkImage;
  final String image;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color:
              bgColor ?? (context.isDarkMode ? CColors.black : CColors.white),
          borderRadius: BorderRadius.circular(100)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  fit: fit,
                  imageUrl: image,
                  color: overlayColor,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const ShimmerLoader(
                    width: 55,
                    height: 55,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  image: AssetImage(image),
                  fit: fit,
                  color: overlayColor,
                ),
        ),
      ),
    );
  }
}
