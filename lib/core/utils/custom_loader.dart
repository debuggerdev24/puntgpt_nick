import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../constants/app_colors.dart' show AppColors;

class FullPageIndicator extends StatelessWidget {
  const FullPageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.black.withValues(alpha: 0.4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(7).r,
        ),
        padding: EdgeInsets.all((kIsWeb && context.isMobile) ? 24 : 12).r,
        child: CupertinoActivityIndicator(
          radius: (kIsWeb && context.isMobile) ? 20.h : 18.h,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

Widget webProgressIndicator(BuildContext context) {
  return SizedBox(
    width: (context.isDesktop) ? 35.w : 45.w,
    height: (context.isDesktop) ? 35.w : 45.w,
    child: CircularProgressIndicator(
      strokeWidth: 2.5,
      color: AppColors.white,
      strokeCap: StrokeCap.round,
    ),
  );
}

class ApiLoadingIndicator extends StatelessWidget {
  const ApiLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.86.sh,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5).r,
        ),
        padding: EdgeInsets.all(12).r,
        child: CupertinoActivityIndicator(
          radius: 18.h,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
