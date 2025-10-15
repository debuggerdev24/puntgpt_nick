import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData appThemeData = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: AppFontFamily.primary,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.primary,
      ),
    ),
  );
}
