import 'package:flutter/material.dart';
import '../constants/app_color.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF121212),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.secondary,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      minimumSize: const Size.fromHeight(48),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade900,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    labelStyle: const TextStyle(color: Colors.white70),
  ),
);
