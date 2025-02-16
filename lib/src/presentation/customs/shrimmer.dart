import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/ui_utils/constants/colors.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15,
      this.color});

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode;
    return Shimmer.fromColors(
        baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color ?? (dark ? CColors.darkerGrey : CColors.white),
              borderRadius: BorderRadius.circular(radius)),
        ));
  }
}
