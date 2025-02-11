// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/// Custom Class for Light & Dark Text Themes
class CCheckboxTheme {
  CCheckboxTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
        side: const BorderSide(color: CColors.textthird, width: 1),
        borderRadius: BorderRadius.circular(
          Sizes.xs,
        )),
  
    checkColor: MaterialStateProperty.resolveWith((states) {
    
      if (states.contains(MaterialState.selected)) {
        return CColors.white;
      } else {
        return CColors.black;
      }
    }),
  
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      } else {
        return Colors.transparent;
      }
    }),
  );

  /// Customizable Dark Text Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.xs)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return CColors.white;
      } else {
        return CColors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return CColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
