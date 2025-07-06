import 'package:flutter/material.dart';

class HibiscusColors {
  // Neutral Base Colors (70%)
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1F1F1F);
  static const Color textSecondary = Color(0xFF5C5C5C);
  static const Color borderColor = Color(0xFFE0E0E0);

  static const Color backgroundDark = Color(0xFF1C1C1C);
  static const Color surfaceDark = Color(0xFF2A2A2A);
  static const Color textPrimaryDark = Color(0xFFEAEAEA);
  static const Color textSecondaryDark = Color(0xFF9E9E9E);

  // Pastel Accents (30%)
  static const Color primary = Color(0xFFB28DFF);      // Pastel violet
  static const Color secondary = Color(0xFF84DCC6);    // Mint green
  static const Color tertiary = Color(0xFFFFBCBC);     // Soft coral
  static const Color highlight = Color(0xFFFFE185);    // Gentle yellow

  // Status
  static const Color success = Color(0xFF9AEBA3);
  static const Color warning = Color(0xFFFFD6A5);
  static const Color error = Color(0xFFFFA3A3);
}

class HibiscusTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: HibiscusColors.backgroundLight,
    primaryColor: HibiscusColors.primary,
    colorScheme: ColorScheme.light(
      primary: HibiscusColors.primary,
      secondary: HibiscusColors.secondary,
      surface: HibiscusColors.surfaceLight,
      error: HibiscusColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: HibiscusColors.textPrimary,
      onError: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: HibiscusColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: HibiscusColors.secondary,
      foregroundColor: Colors.black,
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: HibiscusColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: HibiscusColors.textSecondary,
      ),
    ),
    dividerColor: HibiscusColors.borderColor,
    cardColor: HibiscusColors.surfaceLight,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: HibiscusColors.backgroundDark,
    primaryColor: HibiscusColors.primary,
    colorScheme: ColorScheme.dark(
      primary: HibiscusColors.primary,
      secondary: HibiscusColors.secondary,
      surface: HibiscusColors.surfaceDark,
      error: HibiscusColors.error,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: HibiscusColors.textPrimaryDark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: HibiscusColors.primary,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: HibiscusColors.secondary,
      foregroundColor: Colors.black,
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: HibiscusColors.textPrimaryDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: HibiscusColors.textSecondaryDark,
      ),
    ),
    dividerColor: Colors.grey.shade800,
    cardColor: HibiscusColors.surfaceDark,
  );
}
