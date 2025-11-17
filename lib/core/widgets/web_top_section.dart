import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

import '../../responsive/responsive_builder.dart';

class WebTopSection extends StatelessWidget implements PreferredSizeWidget {
  const WebTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return AppBar(
        backgroundColor: AppColors.primary,
        title: IntrinsicWidth(
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
