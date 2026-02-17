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
      surface: const Color(0xFFF8F9FF),
      onSurface: AppColors.scienceIndigo,
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F9FF),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
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
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
