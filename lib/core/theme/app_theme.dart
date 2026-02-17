import 'package:flutter/material.dart';
import 'package:chemistry_initiative/core/theme/app_colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.scienceIndigo,
      primary: AppColors.scienceIndigo,
      secondary: AppColors.cyanLabs,
      tertiary: AppColors.reactiveGreen,
      surface: const Color(0xFFF0F2F8),
      onSurface: AppColors.scienceIndigo,
    ),
    scaffoldBackgroundColor: const Color(0xFFF0F2F8),
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
      secondary: AppColors.reactiveGreen,
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
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
