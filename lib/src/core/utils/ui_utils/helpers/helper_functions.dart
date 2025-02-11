import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import 'package:url_launcher/url_launcher.dart';

class HelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    context.push(screen);
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  // static bool isDarkMode(BuildContext context) {
  //   return Theme.of(context).brightness == Brightness.dark;
  // }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  // static Future<Map<String, dynamic>> getCurrentLocation(
  //     BuildContext context) async {
  //   LocationPermission locationPermission = await Geolocator.checkPermission();

  //   // Check if permission is denied
  //   if (locationPermission == LocationPermission.denied) {
  //     locationPermission = await Geolocator.requestPermission();
  //     if (locationPermission == LocationPermission.denied) {
  //       await Future.delayed(const Duration(seconds: 1));

  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   // Check if permission is permanently denied
  //   if (locationPermission == LocationPermission.deniedForever) {
  //     await Future.delayed(const Duration(seconds: 1));
  //     //  EasyLoading.dismiss();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.black.withOpacity(0.7),
  //         content: const Text(
  //           "Please enable location permissions in the app settings to access this feature",
  //         ),
  //       ),
  //     );
  //     await openAppSettings();
  //     // EasyLoading.showError(
  //     //     'Location permissions are permanently denied. Please enable them in settings.');
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // If permission is granted
  //   if (locationPermission == LocationPermission.whileInUse ||
  //       locationPermission == LocationPermission.always) {
  //     try {
  //       Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high,
  //       );

  //       List<Placemark> placeMarks = await placemarkFromCoordinates(
  //           position.latitude, position.longitude);

  //       return {
  //         "locality": placeMarks[0].subLocality ?? '',
  //         "city": placeMarks[0].locality ?? '',
  //         'state': placeMarks[0].administrativeArea ?? '',
  //         "pincode": placeMarks[0].postalCode ?? '',
  //       };
  //     } catch (e) {
  //       //  EasyLoading.showInfo('Failed to get current location: $e');
  //       await Future.delayed(
  //           const Duration(seconds: 3)); // Add a delay before dismissing
  //       // EasyLoading.dismiss();
  //       return await Future.error('Failed to get current location: $e');
  //     }
  //   }
  //   await Future.delayed(const Duration(seconds: 2));
  //   // EasyLoading.dismiss();
  //   // EasyLoading.showInfo('Location permission is not granted.');
  //   return Future.error('Location permission is not granted.');
  // }

  static launchDialer(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      String url = 'tel:$phoneNumber';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static sendEmail(
      {required BuildContext context,
      required String emaildata,
      required String subject,
      required String body}) async {
    if (emaildata.isEmpty || emaildata == "null") {
      return showSnackBar("Not valid Phone Number ", context);
    }
    try {
      Uri email = Uri(
        scheme: 'mailto',
        path: emaildata,
        queryParameters: {'subject': subject},
      );

      await launchUrl(email);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static sendToMessage({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    if (phoneNumber.isEmpty || phoneNumber == "null") {
      return showSnackBar("Not valid Phone Number ", context);
    }
    try {
      String url = 'sms: ';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static sendWhatsappMessage({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    if (phoneNumber.isEmpty || phoneNumber == "null") {
      return showSnackBar("Not valid Phone Number ", context);
    }
    phoneNumber = phoneNumber.replaceAll('+', '');
    String url = 'whatsapp://send?phone=$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
