import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../core/utils/ui_utils/constants/colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.assetSt,
    this.size = 24,
    this.color = CColors.primary,
    this.onTap,
    this.transparentBackground = false,
    this.defaultIcon, // New parameter for default icon
    this.width, // New parameter for width
    this.height, // New parameter for height
  });

  final String assetSt;
  final double size;
  final Color color;
  final VoidCallback? onTap;
  final bool transparentBackground;
  final IconData? defaultIcon; // Default icon if image is not provided
  final double? width; // Custom width
  final double? height; // Custom height

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
        radius: (width ?? height ?? size) /
            2, // Set radius based on width/height or size
        child: Container(
          width: width ?? size, // Use custom width or default size
          height: height ?? size, // Use custom height or default size
          child: _buildIcon(isDark), // Build the icon or image
        ),
      ),
    );
  }

  Widget _buildIcon(bool isDark) {
    if (assetSt.isNotEmpty) {
      // If assetSt is provided, display the image
      return ImageIcon(
        AssetImage(assetSt),
        size: size,
        color: isDark ? CColors.white : CColors.primary,
      );
    } else if (defaultIcon != null) {
      // If defaultIcon is provided, display the default icon
      return Icon(
        defaultIcon,
        size: size,
        color: isDark ? CColors.white : CColors.primary,
      );
    } else {
      // If neither is provided, return an empty container
      return Container();
    }
  }
}
