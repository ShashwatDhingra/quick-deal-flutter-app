import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import '../../constants/colors.dart';

/// Custom Class for Light & Dark Text Themes
class CTextTheme {
  CTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
      headlineLarge: const TextStyle().copyWith(
          fontSize: 28.0.sp, fontWeight: FontWeight.bold, color: CColors.dark),
      headlineMedium: const TextStyle().copyWith(
          fontSize: 22.0.sp, fontWeight: FontWeight.w600, color: CColors.dark),
      headlineSmall: const TextStyle().copyWith(
          fontSize: 16.0.sp, fontWeight: FontWeight.w600, color: CColors.dark),
      titleLarge: const TextStyle().copyWith(
          fontSize: 14.0.sp, fontWeight: FontWeight.w600, color: CColors.dark),
      titleMedium: const TextStyle().copyWith(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w500,
          color: CColors.primary),
      titleSmall: const TextStyle().copyWith(
          fontSize: 12.0.sp, fontWeight: FontWeight.bold, color: CColors.dark),
      bodyLarge: const TextStyle().copyWith(
          fontSize: 14.0.sp, fontWeight: FontWeight.w500, color: CColors.dark),
      bodyMedium: const TextStyle().copyWith(
          fontSize: 12.0.sp,
          fontWeight: FontWeight.normal,
          color: CColors.dark),
      bodySmall: const TextStyle().copyWith(
          fontSize: 10.0.sp,
          fontWeight: FontWeight.w500,
          color: CColors.dark.withOpacity(0.5)),
      labelLarge: const TextStyle().copyWith(
          fontSize: 16.0.sp,
          fontWeight: FontWeight.normal,
          color: CColors.dark),
      labelMedium: const TextStyle().copyWith(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.bold,
          color: CColors.dark.withOpacity(0.5)),
      labelSmall: const TextStyle().copyWith(
          fontSize: 12.0.sp,
          fontWeight: FontWeight.normal,
          color: CColors.dark.withOpacity(0.7)));

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: const TextStyle().copyWith(
          fontSize: 28.0.sp, fontWeight: FontWeight.bold, color: CColors.light),
      headlineMedium: const TextStyle().copyWith(
          fontSize: 22.0.sp, fontWeight: FontWeight.w600, color: CColors.light),
      headlineSmall: const TextStyle().copyWith(
          fontSize: 14.0.sp, fontWeight: FontWeight.w600, color: CColors.light),
      titleLarge: const TextStyle().copyWith(
          fontSize: 16.0.sp, fontWeight: FontWeight.w600, color: CColors.light),
      titleMedium: const TextStyle().copyWith(
          fontSize: 14.0.sp, fontWeight: FontWeight.w500, color: CColors.primary),
      titleSmall: const TextStyle().copyWith(
          fontSize: 12.0.sp, fontWeight: FontWeight.bold, color: CColors.light),
      bodyLarge: const TextStyle().copyWith(
          fontSize: 14.0.sp, fontWeight: FontWeight.w500, color: CColors.light),
      bodyMedium: const TextStyle().copyWith(
          fontSize: 12.0.sp, fontWeight: FontWeight.normal, color: CColors.light),
      bodySmall: const TextStyle().copyWith(
          fontSize: 10.0.sp,
          fontWeight: FontWeight.w500,
          color: CColors.light.withOpacity(0.5)),
      labelLarge: const TextStyle().copyWith(
          fontSize: 16.0.sp, fontWeight: FontWeight.normal, color: CColors.light),
      labelMedium: const TextStyle().copyWith(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.bold,
          color: CColors.light.withOpacity(0.5)),
      labelSmall: const TextStyle().copyWith(
          fontSize: 12.0.sp, fontWeight: FontWeight.normal, color: CColors.light));
}
