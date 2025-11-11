import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/text_style.dart';
import '../../core/widgets/app_devider.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topBar(context),
        Padding(
          padding: EdgeInsets.fromLTRB(25.w, 18.h, 0, 0),
          child: Text("Current Plan", style: bold(fontSize: 14)),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 26.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.greyColor.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Text(
                "Free ‘Mug Punter’ Account",
                style: regular(
                  fontFamily: AppFontFamily.secondary,
                  fontSize: 24,
                ),
              ),
              Text(
                "\$ 00.00",
                style: regular(
                  fontFamily: AppFontFamily.secondary,
                  fontSize: 24,
                ),
              ),
              20.h.verticalSpace,

              details(content: "No chat function with PuntGPT"),
              details(content: "No access to PuntGPT Punters Club"),
              details(
                isBenefit: true,
                content: "Limited PuntGPT Search Engine Filters",
              ),
              details(
                isBenefit: true,
                content: "Limited AI analysis of horses",
              ),
              details(isBenefit: true, content: "Access to Classic Form Guide"),
            ],
          ),
        ),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            "Billing handled via Apple Store / Google Play",
            style: medium(
              fontSize: 14,
              color: AppColors.greyColor.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget details({bool? isBenefit, required String content}) {
    return Row(
      spacing: 10.w,
      children: [
        Icon(
          isBenefit ?? false ? Icons.check_rounded : Icons.close_rounded,
          color: isBenefit ?? false ? AppColors.green : AppColors.red,
        ),
        Expanded(child: Text(content)),
      ],
    );
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 16.h),
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
                    "Manage Subscription",
                    style: regular(
                      fontSize: 24,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Manage your Subscription Plan",
                    style: semiBold(
                      fontSize: 14,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        appDivider(),
      ],
    );
  }
}
