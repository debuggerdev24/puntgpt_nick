import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/account/mobile/widgets/subscription_plan.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/app_filed_button.dart';
import '../../../core/widgets/app_outlined_button.dart';

class CurrentPlanScreen extends StatelessWidget {
  const CurrentPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, provider, child) => Column(
        children: [
          topBar(context),
          SubscriptionPlanMobile(plan: provider.plans[0]),
          // if (context.isBrowserMobile) 40.w.verticalSpace,
          Center(
            child: Text(
              "Billing handled via Apple Store / Google Play",
              style: medium(
                fontSize: 14.sp,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ),
          ),
          Spacer(),
          AppFiledButton(
            margin: EdgeInsets.only(bottom: 10.h, left: 25.w, right: 25.w),
            text: "Renew",
            textStyle: semiBold(
              fontSize: (context.isBrowserMobile) ? 30.sp : 18.sp,
              color: AppColors.white,
            ),
            onTap: () {},
          ),
          AppOutlinedButton(
            margin: EdgeInsets.only(bottom: 10.h, left: 25.w, right: 25.w),
            text: "Change Plan",
            textStyle: semiBold(
              fontSize: (context.isBrowserMobile) ? 30.sp : 18.sp,
            ),
            onTap: () {},
          ),
          AppOutlinedButton(
            margin: EdgeInsets.only(bottom: 25.h, left: 25.w, right: 25.w),
            text: "Cancel",
            textStyle: semiBold(
              fontSize: (context.isBrowserMobile) ? 30.sp : 18.sp,
            ),
            onTap: () {
              context.pop();
            },
          ),
        ],
      ),
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
                    "Manage Subscription",
                    style: regular(
                      fontSize: (context.isBrowserMobile) ? 36.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Manage your Subscription Plan",
                    style: semiBold(
                      fontSize: (context.isBrowserMobile) ? 28.sp : 14.sp,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}
