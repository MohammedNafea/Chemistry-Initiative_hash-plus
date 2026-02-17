import 'package:flutter/material.dart';
import 'package:chemistry_initiative/core/theme/app_colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo', // Assuming Cairo font from QuestionPage
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkBrown,
      primary: AppColors.darkBrown,
      secondary: AppColors.softBrown,
      surface: AppColors.lightBackground,
      onSurface: AppColors.darkBrown,

    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.darkBrown),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkBrown,
      brightness: Brightness.dark,
      primary: AppColors.softBrown,
      secondary: AppColors.darkBrown,
      surface: AppColors.darkSurface,
      onSurface: Colors.white,

    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
     appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
