import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/app_assets.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/text_style.dart';
import '../../core/widgets/app_devider.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBar(context),
        28.h.verticalSpace,
        //todo form
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo --------------> name
                  Text("Name", style: semiBold(fontSize: 14)),
                  6.h.verticalSpace,
                  AppTextField(
                    controller: TextEditingController(),
                    hintText: "Enter Your Name",
                  ),
                  //todo --------------> email
                  14.h.verticalSpace,
                  Text("Email", style: semiBold(fontSize: 14)),
                  6.h.verticalSpace,
                  AppTextField(
                    controller: TextEditingController(),
                    hintText: "Enter Your Email",
                  ),
                  //todo --------------> phone
                  14.h.verticalSpace,
                  Text("Phone", style: semiBold(fontSize: 14)),
                  6.h.verticalSpace,
                  AppTextField(
                    controller: TextEditingController(),
                    hintText: "Enter Your Phone",
                  ),
                  AppOutlinedButton(
                    text: "Change Password",
                    onTap: () {
                      context.pushNamed(AppRoutes.changePassword.name);
                    },
                    margin: EdgeInsets.only(bottom: 30.h, top: 200.h),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5.w, 12.h, 25.w, 16.h),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,

                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Details",
                    style: regular(
                      fontSize: 24,
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
