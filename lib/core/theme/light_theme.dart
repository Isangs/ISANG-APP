import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../constants/text_styles.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: AppColor.background,
  textTheme: const TextTheme(
    titleLarge: AppTextStyles.loginMainTitle,
    bodyLarge: AppTextStyles.loginsubtitle,
    labelLarge: AppTextStyles.button,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.primary,
      foregroundColor: Colors.white,
      textStyle: AppTextStyles.button,
      minimumSize: const Size.fromHeight(48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColor.backgroundLight,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    labelStyle: AppTextStyles.loginsubtitle,
  ),
);
