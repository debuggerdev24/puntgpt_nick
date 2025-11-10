import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';

class AppFontFamily {
  AppFontFamily._();

  static const primary = "DMSans";
  static const secondary = "ChangaOne";
}

/// Base text style builder
TextStyle _baseTextStyle({
  required FontWeight fontWeight,
  double fontSize = 20,
  double? height,
  Color? color,
  String? fontFamily,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  double? letterSpacing,
  FontStyle? fontStyle,
}) {
  return TextStyle(
    fontSize: fontSize.spMin,
    height: height,
    color: color ?? AppColors.primary,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontStyle: fontStyle ?? FontStyle.normal, // ✅ default normal
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
    letterSpacing: letterSpacing,
  );
}

/// 🪶 Light
TextStyle light({
  double fontSize = 20,
  double? height,
  Color? color,
  String? fontFamily,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  double? letterSpacing,
  FontStyle? fontStyle,
}) => _baseTextStyle(
  fontWeight: FontWeight.w300,
  fontSize: fontSize.spMin,
  height: height,
  color: color,
  fontFamily: fontFamily,
  decoration: decoration,
  decorationColor: decorationColor,
  decorationStyle: decorationStyle,
  decorationThickness: decorationThickness,
  letterSpacing: letterSpacing,
  fontStyle: fontStyle,
);

/// Regular
TextStyle regular({
  double fontSize = 20,
  double? height,
  Color? color,
  String? fontFamily,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  double? letterSpacing,
  FontStyle? fontStyle,
}) => _baseTextStyle(
  fontWeight: FontWeight.w400,
  fontSize: fontSize.spMin,
  height: height,
  color: color,
  fontFamily: fontFamily,
  decoration: decoration,
  decorationColor: decorationColor,
  decorationStyle: decorationStyle,
  decorationThickness: decorationThickness,
  letterSpacing: letterSpacing,
  fontStyle: fontStyle,
);

/// Medium
TextStyle medium({
  double fontSize = 20,
  double? height,
  Color? color,
  String? fontFamily,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  double? letterSpacing,
  FontStyle? fontStyle,
}) => _baseTextStyle(
  fontWeight: FontWeight.w500,
  fontSize: fontSize.spMin,
  height: height,
  color: color,
  fontFamily: fontFamily,
  decoration: decoration,
  decorationColor: decorationColor,
  decorationStyle: decorationStyle,
  decorationThickness: decorationThickness,
  letterSpacing: letterSpacing,
  fontStyle: fontStyle,
);

/// SemiBold
TextStyle semiBold({
  double fontSize = 20,
  double? height,
  Color? color,
  String? fontFamily,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  double? letterSpacing,
  FontStyle? fontStyle,
}) => _baseTextStyle(
  fontWeight: FontWeight.w600,
  fontSize: fontSize.spMin,
  height: height,
  color: color,
  fontFamily: fontFamily,
  decoration: decoration,
  decorationColor: decorationColor,
  decorationStyle: decorationStyle,
  decorationThickness: decorationThickness,
  letterSpacing: letterSpacing,
  fontStyle: fontStyle,
);

/// Bold
TextStyle bold({
  double fontSize = 20,
  double? height,
  Color? color,
  String? fontFamily,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  double? letterSpacing,
  FontStyle? fontStyle,
}) => _baseTextStyle(
  fontWeight: FontWeight.w700,
  fontSize: fontSize.spMin,
  height: height,
  color: color,
  fontFamily: fontFamily,
  decoration: decoration,
  decorationColor: decorationColor,
  decorationStyle: decorationStyle,
  decorationThickness: decorationThickness,
  letterSpacing: letterSpacing,
  fontStyle: fontStyle,
);
