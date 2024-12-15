import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.lightBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightBackground,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.lightPrimaryText),
    bodyMedium: TextStyle(color: AppColors.lightPrimaryText),
    bodySmall: TextStyle(color: AppColors.lightSecondaryText),
    titleLarge: TextStyle(color: AppColors.lightPrimaryText),
    titleMedium: TextStyle(color: AppColors.lightPrimaryText),
    titleSmall: TextStyle(color: AppColors.lightPrimaryText),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary, // Button color
      foregroundColor: Colors.white, // Text color
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightInputFill,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error),
    ),
  ),
  dividerColor: AppColors.divider,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.darkPrimaryText,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkPrimaryText),
    bodyMedium: TextStyle(color: AppColors.darkSecondaryText),
    bodySmall: TextStyle(color: AppColors.darkSecondaryText),
    titleLarge: TextStyle(color: AppColors.darkPrimaryText),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary, // Button color
      foregroundColor: Colors.white, // Text color
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkInputFill,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error),
    ),
  ),
  dividerColor: AppColors.divider,
);
