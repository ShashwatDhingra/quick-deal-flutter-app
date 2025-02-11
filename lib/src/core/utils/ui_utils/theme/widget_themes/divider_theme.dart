import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class CDividerTheme {
  CDividerTheme._();

  static DividerThemeData lightDividerTheme = DividerThemeData(
    color: CColors.grey.withOpacity(0.6),
    thickness: Sizes.dividerThickness,
    space: Sizes.dividerSpace,
    indent: Sizes.dividerIndent,
    endIndent: Sizes.dividerEndIndent,
  );

  static DividerThemeData darkDividerTheme = DividerThemeData(
    color: CColors.textWhite.withOpacity(0.4),
    thickness: Sizes.dividerThickness,
    space: Sizes.dividerSpace,
    indent: Sizes.dividerIndent,
    endIndent: Sizes.dividerEndIndent,
  );
}
