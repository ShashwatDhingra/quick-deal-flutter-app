
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../core/utils/ui_utils/constants/colors.dart';


class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.assetSt,
      this.size = 24,
      this.color = CColors.primary,
      this.onTap,
      this.transparentBackground = false});

  final String assetSt;
  final double size;
  final Color color;
  final VoidCallback? onTap;
  final bool transparentBackground;

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: transparentBackground
            ? Colors.transparent
            : isDark
                ? CColors.darkContainer
                : CColors.primary.withOpacity(0.07),
        child: ImageIcon(
          AssetImage(assetSt),
          size: size,
          color: isDark ? CColors.white : CColors.primary,
        ),
      ),
    );
  }
}
