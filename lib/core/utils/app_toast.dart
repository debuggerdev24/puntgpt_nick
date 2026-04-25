import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  // Base show method
  static void show({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    Color? textColor,
    Icon? icon,
    ToastificationType type = ToastificationType.info,
    Duration? duration,
  }) {
    toastification.show(
      primaryColor: AppColors.white,
      borderSide: BorderSide(color: AppColors.transparent),
      context: context,
      type: type,
      backgroundColor: backgroundColor,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      alignment: kIsWeb ? Alignment.topRight : Alignment.topCenter,
      // margin: kIsWeb ? const EdgeInsets.only(top: 12, right: 12) : null,
      icon: icon,
      title: Text(
        message,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        style: medium(
          color: textColor ?? AppColors.white,
          fontSize: (kIsWeb) ? 16 : 18.sp,
        ),
      ),
    );
  }
  //

  static void success({
    required BuildContext context,
    required String message,
    Duration? duration,
  }) {
    show(
      context: context,
      message: message,
      type: ToastificationType.success,
      backgroundColor: Colors.green.shade600,
      duration: duration,
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
