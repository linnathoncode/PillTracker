import 'package:flutter/material.dart';
import 'package:pill_tracker/core/configs/theme/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      centerTitle: true,
    ),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightSurface,
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      sizeConstraints: const BoxConstraints.tightFor(
        width: 60,
        height: 60,
      ),
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primary,
      iconSize: 30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.lightSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      centerTitle: true,
    ),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkSurface,
    brightness: Brightness.dark,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      sizeConstraints: const BoxConstraints.tightFor(
        width: 60,
        height: 60,
      ),
      iconSize: 30,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
