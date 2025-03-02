import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/theme/widget_themes/drawer_theme.dart';

import '../constants/colors.dart';
import 'widget_themes/appbar_theme.dart';
import 'widget_themes/bottom_sheet_theme.dart';
import 'widget_themes/checkbox_theme.dart';
import 'widget_themes/chip_theme.dart';
import 'widget_themes/cupertino_dialog_theme.dart';
import 'widget_themes/divider_theme.dart';
import 'widget_themes/dropdown_theme.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/outlined_button_theme.dart';
import 'widget_themes/progress_indicator_theme.dart';
import 'widget_themes/slider_theme.dart';
import 'widget_themes/text_button_theme.dart';
import 'widget_themes/text_field_theme.dart';
import 'widget_themes/text_theme.dart';

class CAppTheme {
  CAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      disabledColor: CColors.grey,
      brightness: Brightness.light,
      primaryColor: CColors.primary,
      textTheme: CTextTheme.lightTextTheme,
      chipTheme: CChipTheme.lightChipTheme,
      scaffoldBackgroundColor: CColors.white,
      appBarTheme: CAppBarTheme.lightAppBarTheme,
      checkboxTheme: CCheckboxTheme.lightCheckboxTheme,
      bottomSheetTheme: CBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: COutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: CTextFormFieldTheme.lightInputDecorationTheme,
      dropdownMenuTheme: CDropdownTheme.lightDropdownButtonTheme,
      dividerTheme: CDividerTheme.lightDividerTheme,
      cupertinoOverrideTheme: CCupertinoDialogTheme.lightCupertinoTheme,
      textButtonTheme: CTextButtonTheme.lightTextButtonTheme,
      progressIndicatorTheme:
          CProgressIndicatorTheme.lightProgressIndicatorTheme,
      splashFactory: NoSplash.splashFactory,
      drawerTheme: CDrawerTheme.lightDrawerTheme,
      sliderTheme: CSliderTheme.lightSliderTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      disabledColor: CColors.grey,
      brightness: Brightness.dark,
      primaryColor: CColors.primary,
      textTheme: CTextTheme.darkTextTheme,
      chipTheme: CChipTheme.darkChipTheme,
      scaffoldBackgroundColor: CColors.black,
      appBarTheme: CAppBarTheme.darkAppBarTheme,
      checkboxTheme: CCheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: CBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: COutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: CTextFormFieldTheme.darkInputDecorationTheme,
      dropdownMenuTheme: CDropdownTheme.darkDropdownButtonTheme,
      dividerTheme: CDividerTheme.darkDividerTheme,
      cupertinoOverrideTheme: CCupertinoDialogTheme.darkCupertinoTheme,
      textButtonTheme: CTextButtonTheme.darkTextButtonTheme,
      progressIndicatorTheme:
          CProgressIndicatorTheme.darkProgressIndicatorTheme,
      splashFactory: NoSplash.splashFactory,
      drawerTheme: CDrawerTheme.darkDrawerTheme,
      sliderTheme: CSliderTheme.darkSliderTheme);
}
