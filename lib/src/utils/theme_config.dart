import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/text_util.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      weight: 1,
      size: 20,
    ),
    fontFamily: "SF-Pro",
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.grey50, width: 0),
        borderRadius: BorderRadius.circular(12),
      ),
      hintStyle: normalStyle(16, AppColors.grey400),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary400),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      fillColor: AppColors.grey50,
      filled: true,
    ),
  );
}
