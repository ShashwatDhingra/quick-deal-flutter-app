import 'package:flutter/cupertino.dart';

import '../../constants/colors.dart';

class CCupertinoDialogTheme {
  CCupertinoDialogTheme._();

  static CupertinoThemeData lightCupertinoTheme = const CupertinoThemeData(
    primaryColor: CColors.primary, // Primary color for buttons and highlights
    textTheme: CupertinoTextThemeData(
      actionTextStyle: TextStyle(
        fontSize: 16,
        color: CColors.primary,
        fontWeight: FontWeight.bold,
      ), // Style for dialog buttons
      textStyle: TextStyle(
        fontSize: 16,
        color: CColors.black,
      ), // General text style
      navTitleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: CColors.black,
      ), // Title style
    ),
    barBackgroundColor: CColors.white,
    scaffoldBackgroundColor: CColors.white,
  );

  static CupertinoThemeData darkCupertinoTheme = const CupertinoThemeData(
    primaryColor: CColors.primary, // Primary color for buttons and highlights
    textTheme: CupertinoTextThemeData(
      actionTextStyle: TextStyle(
        fontSize: 16,
        color: CColors.primary,
        fontWeight: FontWeight.bold,
      ), // Style for dialog buttons
      textStyle: TextStyle(
        fontSize: 16,
        color: CColors.white,
      ), // General text style
      navTitleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: CColors.white,
      ), // Title style
    ),
    barBackgroundColor: CColors.darkGrey,
    scaffoldBackgroundColor: CColors.darkerGrey,
  );
}
