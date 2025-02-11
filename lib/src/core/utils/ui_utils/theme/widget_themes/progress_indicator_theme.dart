import 'package:flutter/material.dart';
import '../../constants/colors.dart';

/* -- Light & Dark Progress Indicator Themes -- */
class CProgressIndicatorTheme {
  CProgressIndicatorTheme._(); 

  /* -- Light Theme -- */
  static const lightProgressIndicatorTheme = ProgressIndicatorThemeData(
    color: CColors.primary,
    linearTrackColor: CColors.lightGrey,
    refreshBackgroundColor: CColors.light,
    circularTrackColor: CColors.lightGrey,
  );

  /* -- Dark Theme -- */
  static const darkProgressIndicatorTheme = ProgressIndicatorThemeData(
    color: CColors.primary,
    linearTrackColor: CColors.darkerGrey,
    refreshBackgroundColor: CColors.dark,
    circularTrackColor: CColors.darkGrey,
  );
}
