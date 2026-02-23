import 'package:flutter/material.dart';
import 'package:chemistry_initiative/core/theme/app_colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.scienceIndigo,
      primary: AppColors.scienceIndigo,
      secondary: AppColors.warmOrange, // Warmer accent
      tertiary: AppColors.reactiveGreen,
      surface: AppColors.softBeige, // Warmer surface
      onSurface: AppColors.cozyBrown, // Softer text
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F5F2), // Warm off-white
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.scienceIndigo,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
      iconTheme: IconThemeData(color: AppColors.scienceIndigo),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.scienceIndigo,
      brightness: Brightness.dark,
      primary: AppColors.cyanLabs,
      secondary: AppColors.warmOrange,
      surface: AppColors.labSurface,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.deepSpace,
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.labSurface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontFamily: 'Cairo'),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );

  static final ThemeData highContrastDark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.yellow,
      surface: Colors.black,
      onSurface: Colors.white,
      error: Colors.redAccent,
    ),
    scaffoldBackgroundColor: Colors.black,
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.white24, width: 2),
      ),
      color: const Color(0xFF111111),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w900,
        fontFamily: 'Cairo',
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
