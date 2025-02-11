// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../core/utils/ui_utils/helpers/helper_functions.dart';

class MOutlinedButton extends StatelessWidget {
  MOutlinedButton({
    super.key,
    required this.text,
    required this.onPress,
    this.textStyle = const TextStyle(),
    this.isLoading = false,
    double? height,
  }) : height = height ?? 44.0.w;

  final String text;
  final VoidCallback onPress;
  final TextStyle? textStyle;

  final bool isLoading;
  double height;
  @override
  Widget build(BuildContext context) {
    final double scWidth = HelperFunctions.screenWidth(context);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.0),
          ),
          minimumSize: Size(scWidth * 0.9, 48),
        ),
        onPressed: isLoading ? null : onPress,
        child: isLoading
            ? const SpinKitFadingCircle(color: Colors.white, size: 18)
            : Text(
                text,
              ),
      ),
    );
  }
}
