import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class CDrawerTheme {
  CDrawerTheme._();

  static const lightDrawerTheme = DrawerThemeData(
    elevation: 0,
    backgroundColor: CColors.white,
    surfaceTintColor: CColors.transparent,
    scrimColor: Colors.black54,
    width: 302, // Assuming you have a constant for drawer width
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.horizontal(right: Radius.circular(Sizes.borderRadiusLg)),
    ),
  );

  static const darkDrawerTheme = DrawerThemeData(
    elevation: 0,
    backgroundColor: CColors.black,
    surfaceTintColor: CColors.transparent,
    scrimColor: Colors.white54,
    width: 304, // Standard drawer width
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.horizontal(right: Radius.circular(Sizes.borderRadiusLg)),
    ),
  );
}
