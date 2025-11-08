import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/text_style.dart';

class AskPuntGpt extends StatelessWidget {
  const AskPuntGpt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 8.h),
          child: Row(
            spacing: 16.w,
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.arrow_back_ios_rounded, size: 12.h),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ask @PuntGPT",
                    style: regular(
                      fontFamily: AppFontFamily.secondary,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    "Manage your saved search",
                    style: medium(
                      fontSize: 14.sp,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
