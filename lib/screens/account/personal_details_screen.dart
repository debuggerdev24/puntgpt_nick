import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/app_assets.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/text_style.dart';
import '../../core/widgets/app_devider.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [topBar(context)]);
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 12.h),
          child: Row(
            spacing: 14.w,
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Details",
                    style: regular(
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Manage your name, email, etc.",
                    style: semiBold(
                      fontSize: 14,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              Spacer(),
              SvgPicture.asset(AppAssets.edit),
              Text("Edit", style: bold(fontSize: 16)),
            ],
          ),
        ),
        appDivider(),
      ],
    );
  }
}
