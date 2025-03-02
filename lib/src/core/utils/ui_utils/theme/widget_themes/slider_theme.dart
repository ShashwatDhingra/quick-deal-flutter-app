import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CSliderTheme {
  CSliderTheme._();

  static SliderThemeData lightSliderTheme = SliderThemeData(
    activeTrackColor: CColors.primary,
    inactiveTrackColor: CColors.grey.withOpacity(0.4),
    thumbColor: CColors.primary,
    overlayColor: CColors.primary.withOpacity(0.2),
    valueIndicatorColor: CColors.primary,
    activeTickMarkColor: CColors.white,
    inactiveTickMarkColor: CColors.grey,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
    valueIndicatorTextStyle: const TextStyle(
      color: CColors.white,
      fontSize: 14.0,
    ),
  );

  static SliderThemeData darkSliderTheme = SliderThemeData(
    activeTrackColor: CColors.primary,
    inactiveTrackColor: CColors.darkerGrey,
    thumbColor: CColors.primary,
    overlayColor: CColors.primary.withOpacity(0.2),
    valueIndicatorColor: CColors.primary,
    activeTickMarkColor: CColors.white,
    inactiveTickMarkColor: CColors.darkerGrey,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
    valueIndicatorTextStyle: const TextStyle(
      color: CColors.white,
      fontSize: 14.0,
    ),
  );
}
