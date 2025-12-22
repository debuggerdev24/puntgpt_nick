import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../constants/app_colors.dart';
import '../constants/text_style.dart';

class AppToast {
  // Base show method
  static void show({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    Color? textColor,
    Icon? icon,
    ToastificationType type = ToastificationType.info,
    Duration? duration = const Duration(seconds: 2),
  }) {
    toastification.show(
      primaryColor: AppColors.white,
      borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.5)),
      context: context,
      type: type,
      backgroundColor: backgroundColor,
      autoCloseDuration: duration,
      alignment: Alignment.topCenter,

      icon: icon,
      title: Text(
        message,
        style: medium(color: textColor ?? AppColors.white, fontSize: 15.sp),
      ),
    );
  }
  //

  static void success({
    required BuildContext context,
    required String message,
  }) {
    show(
      context: context,
      message: message,
      type: ToastificationType.success,
      backgroundColor: Colors.green.shade600,
    );
  }

  static void error({required BuildContext context, required String message}) {
    show(
      context: context,
      message: message,
      type: ToastificationType.error,
      backgroundColor: Colors.red.shade600,
    );
  }

  static void warning({
    required BuildContext context,
    required String message,
  }) {
    show(
      context: context,
      message: message,
      textColor: AppColors.black,
      type: ToastificationType.warning,
      backgroundColor: Colors.yellow,
      icon: Icon(Icons.warning_amber_rounded, color: AppColors.black),
    );
  }

  static void info({
    required BuildContext context,
    required String message,
    int? durationSecond,
  }) {
    show(
      context: context,
      message: message,
      type: ToastificationType.info,
      backgroundColor: Colors.blue,
      duration: (durationSecond == null)
          ? null
          : Duration(seconds: durationSecond),
    );
  }
}
