import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class CTextFormFieldTheme {
  CTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: CColors.darkGrey,
    suffixIconColor: CColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: Sizes.fontSizeMd, color: CColors.textSecondary),
    hintStyle: const TextStyle()
        .copyWith(fontSize: Sizes.fontSizeSm, color: CColors.darkGrey),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, color: CColors.error),
    floatingLabelStyle:
        const TextStyle().copyWith(color: CColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CColors.black),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CColors.black),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CColors.primary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: CColors.primary),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: CColors.darkGrey,
    suffixIconColor: CColors.darkGrey,

    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: Sizes.fontSizeMd, color: CColors.darkGrey),
    hintStyle: const TextStyle()
        .copyWith(fontSize: Sizes.fontSizeSm, color: CColors.white),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, color: CColors.error),
    floatingLabelStyle:
        const TextStyle().copyWith(color: CColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CColors.white),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CColors.white),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CColors.primary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: CColors.primary),
    ),
  );
}
