import 'package:flutter/material.dart';

class CColors {
  // App theme colors
  //static const Color primary = Color(0xffC8145c);
  static const Color primary = Color(0xFF7A5AF8);
  static final primarySecondary =
      const Color.fromARGB(255, 78, 181, 209).withOpacity(0.3);
  static const Color primaryWithOpacity = Color(0xffe86969);
  static const Color secondary = Color(0xFF795FFC);
  static const Color accent = Color(0xFFb0c7ff);
  static const Color transparent = Colors.transparent;

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textthird = Color(0xFF595959);
  static const Color textWhite = CColors.white;

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = CColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

  // Summery Tile Colors
  static const Color pendingTileColor = Color(0xFFC4FFD1);
  static const Color openTileColor = Color(0xFFBBDDFF);
  static const Color closedTileColor = Color(0xFFFFDDBD);
  static const Color escalationTileColor = Color(0xFFC4FFD1);

  // summary tile count color
  static const Color pendingCountTileColor = Color(0xFF5FB372);
  static const Color openCountTileColor = Color(0xFF729DC8);
  static const Color closedCountTileColor = Color(0xFFD09A67);
  static const Color escalationCountTileColor = Color(0xFFC4FFD1);
}
