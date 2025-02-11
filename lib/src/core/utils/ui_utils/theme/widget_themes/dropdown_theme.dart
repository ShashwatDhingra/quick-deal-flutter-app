import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class CDropdownTheme {
  CDropdownTheme._();

  static DropdownMenuThemeData lightDropdownButtonTheme = DropdownMenuThemeData(
    textStyle: const TextStyle(
      fontSize: Sizes.fontSizeMd,
      color: CColors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
        borderSide: const BorderSide(color: CColors.grey, width: 1),
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(CColors.white),
      surfaceTintColor: WidgetStateProperty.all(CColors.white),
      side: WidgetStateProperty.all(
          const BorderSide(color: CColors.buttonSecondary)),
      padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8, horizontal: 12)),
    ),
  );

  static DropdownMenuThemeData darkDropdownButtonTheme = DropdownMenuThemeData(
    textStyle: const TextStyle(
      fontSize: Sizes.fontSizeMd,
      color: CColors.textWhite,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: Colors.amber),
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(CColors.black),
      surfaceTintColor: WidgetStateProperty.all(CColors.black),
      side: WidgetStateProperty.all(
          const BorderSide(color: CColors.borderPrimary)),
      padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8, horizontal: 12)),
    ),
  );
}
