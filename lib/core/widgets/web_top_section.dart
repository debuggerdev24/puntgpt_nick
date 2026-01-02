import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

import '../../responsive/responsive_builder.dart';

class WebTopSection extends StatelessWidget implements PreferredSizeWidget {
  const WebTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return AppBar(
        backgroundColor: AppColors.primary,
        title: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // 20.h.verticalSpace,
              Text(
                "Visit UK Site",
                style: bold(
                  fontSize: 16.sp.flexClamp(12, 18),
                  color: AppColors.white,
                ),
              ),
              Container(color: AppColors.white, height: 2),
              // if (context.isMobile) 10.h.verticalSpace else SizedBox(),
            ],
          ),
        ),
      );
    }
    return Container(
      width: double.maxFinite,
      color: AppColors.primary,
      alignment: Alignment.center,
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Visit UK Site",
              style: bold(
                fontSize: 16.sp.flexClamp(12, 16),
                color: AppColors.white,
              ),
            ),
            Container(color: AppColors.white, height: 2),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.w.flexClamp(40, 45));
}
