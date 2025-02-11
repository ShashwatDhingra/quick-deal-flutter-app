import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light Theme for DateTimeField -- */
class CDateTimeFieldTheme {
  CDateTimeFieldTheme._();

  /// light theme for DateTimeField
  static final lightDateTimeFieldTheme = InputDecorationTheme(
    filled: true,
    fillColor: CColors.dark,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
      borderSide: const BorderSide(color: CColors.primary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
      borderSide: const BorderSide(color: CColors.primary),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
      borderSide: const BorderSide(color: CColors.buttonDisabled),
    ),
    contentPadding: const EdgeInsets.symmetric(
        vertical: Sizes.borderRadiusMd, horizontal: Sizes.borderRadiusMd),
    hintStyle: const TextStyle(fontSize: 14, color: CColors.darkGrey),
    labelStyle: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: CColors.darkGrey),
  );

  /// dark Theme for  DateTimeField
  static final darkDateTimeFieldTheme = InputDecorationTheme(
    filled: true,
    fillColor: CColors.darkContainer,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
      borderSide: const BorderSide(color: CColors.primary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
      borderSide: const BorderSide(color: CColors.textWhite),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
      borderSide: const BorderSide(color: CColors.darkerGrey),
    ),
    contentPadding: const EdgeInsets.symmetric(
        vertical: Sizes.borderRadiusMd, horizontal: Sizes.borderRadiusMd),
    hintStyle: const TextStyle(fontSize: 14, color: CColors.textWhite),
    labelStyle: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: CColors.textWhite),
  );
}
