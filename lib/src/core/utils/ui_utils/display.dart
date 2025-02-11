import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/services.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

class DisplayUtils {
  static showToast(String message, bool isError, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          isDismissible: true,
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: 3.seconds,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(16), topRight: Radius.circular(16)),
          backgroundColor:
              isError ? Colors.red.shade100 : Colors.green.shade100,
          margin: const EdgeInsets.all(20),
          messageText: Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.w200),
          ),
          titleColor: Colors.black,
          titleText: Text(isError ? 'Error' : 'Success',
              style: const TextStyle(fontWeight: FontWeight.w400)),
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
                backgroundColor: isError ? Colors.transparent : Colors.green,
                child: isError
                    ? const Icon(Icons.info, color: Colors.red, size: 30)
                    : const Icon(Icons.done, size: 32)),
          ),
        )..show(context));
  }

  static void triggerHapticFeedback() {
    HapticFeedback
        .mediumImpact(); // can also use `lightImpact` or `heavyImpact`
  }
}

/// screen utils package
/// HelperFunctions.screenWidth(context);
class ScreenUtilService {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _scaleWidth;
  static late double _scaleHeight;

  // Initialize other variables, if necessary.
  static Future<void> init(BuildContext context) async {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;

    _scaleWidth = _screenWidth / 375.0; // Assuming base width is 375
    _scaleHeight = _screenHeight / 812.0; // Assuming base height is 812

    // Remove or properly handle any unused variables like _minTextAdapt.
  }

  static double scaleWidth(double width) => width * _scaleWidth;
  static double scaleHeight(double height) => height * _scaleHeight;
  static double scaleFont(double fontSize) =>
      fontSize * (_scaleWidth < _scaleHeight ? _scaleWidth : _scaleHeight);
}
