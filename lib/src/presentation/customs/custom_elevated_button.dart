import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/utils/ui_utils/constants/colors.dart';
import '../../core/utils/ui_utils/helpers/helper_functions.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPress,
    this.isLoading = false,
    this.height = 48.0,
    this.buttonColor = CColors.primary,
  });

  final String text;
  final VoidCallback onPress;

  final bool isLoading;
  final double height;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    final double scWidth = HelperFunctions.screenWidth(context);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.0),
            
          ),
          padding: const EdgeInsets.all(12.0),
          minimumSize: Size(scWidth * 0.9, 48),
        ),
        onPressed: isLoading ? null : onPress,
        child: isLoading
            ? const SpinKitFadingCircle(color: Colors.white, size: 18)
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
      ),
    );
  }
}
