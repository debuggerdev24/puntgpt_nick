import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.primary,
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appThemeData,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
