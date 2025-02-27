import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickdeal/src/core/utils/ui_utils/display.dart';

extension MySizedBox on num {
  SizedBox get hBox => SizedBox(height: toDouble());
  SizedBox get vBox => SizedBox(width: toDouble());
}

// For resposive ui w for width and h for height sp for font size
extension ScreenUtilExtension on num {
  double get w => ScreenUtilService.scaleWidth(toDouble());
  double get h => ScreenUtilService.scaleHeight(toDouble());
  double get sp => ScreenUtilService.scaleFont(toDouble());
}

extension Navigation on BuildContext {
  /// Navigate to a new screen.
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  /// Navigate to a new screen and remove all previous screens from the stack.
  Future<T?> pushAndRemoveUntil<T>(Widget page,
      {bool Function(Route<dynamic>)? predicate}) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      predicate ?? (route) => false,
    );
  }

  /// Replace the current screen with a new one.
  Future<T?> pushReplacement<T, R>(Widget page, {R? result}) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
      result: result,
    );
  }

  /// Pop the current screen and return to the previous one.
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Pop all screens until the predicate matches.
  void popUntil(bool Function(Route<dynamic>) predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// Check if the navigator can pop.
  bool canPop() {
    return Navigator.of(this).canPop();
  }

  /// Push a named route.
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  /// Push a named route and remove all previous screens from the stack.
  Future<T?> pushNamedAndRemoveUntil<T>(String routeName,
      {bool Function(Route<dynamic>)? predicate, Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
        routeName, predicate ?? (route) => false,
        arguments: arguments);
  }

  /// Replace the current screen with a named route.
  Future<T?> pushReplacementNamed<T, R>(String routeName,
      {R? result, Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments, result: result);
  }

  /// Pop the current screen with a named route.
  void popNamed<T>(T? result) {
    Navigator.of(this).pop(result);
  }
}

extension IntToDuration on int {
  Duration get seconds => Duration(seconds: this);
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);
}

// Custom padding extension
extension PaddingExtension on Widget {
  Widget withPadding(EdgeInsets padding) =>
      Padding(padding: padding, child: this);

  Widget withSymmetricPadding({double vertical = 0, double horizontal = 0}) =>
      Padding(
          padding: EdgeInsets.symmetric(
              vertical: vertical.h, horizontal: horizontal.w),
          child: this);

  Widget withAllPadding(double value) =>
      Padding(padding: EdgeInsets.all(value.sp), child: this);
}

// Show widget on conditional
extension ConditionalWidget on Widget {
  Widget showIf(bool condition) => condition ? this : const SizedBox.shrink();
}

// Merge two map
extension DeepMerge on Map {
  Map deepMerge(Map other) {
    final result = Map.of(this);
    other.forEach((key, value) {
      if (result[key] is Map && value is Map) {
        result[key] = (result[key] as Map).deepMerge(value);
      } else {
        result[key] = value;
      }
    });
    return result;
  }
}

//  Check dark mode of mobile app
extension ThemeModeExtensions on BuildContext {
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }
}

extension UIExtensions on String {
  void showErrorToast() {
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}
