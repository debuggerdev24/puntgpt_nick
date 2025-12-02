import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/image_widget.dart';

List activePlan = [
  {"icon": AppAssets.done, "point": "Chat function with PuntGPT"},
  {"icon": AppAssets.done, "point": "Access to PuntGPT Punters Club"},
  {"icon": AppAssets.done, "point": "Full use of PuntGPT Search Engine"},
  {"icon": AppAssets.done, "point": "Access to Classic Form Guide"},
];

List freePlan = [
  {"icon": AppAssets.close, "point": "No chat function with PuntGPT"},
  {"icon": AppAssets.close, "point": "No chat function with PuntGPT"},
  {"icon": AppAssets.done, "point": "Limited PuntGPT Search Engine Filters"},
  {"icon": AppAssets.done, "point": "Limited AI analysis of horses"},
  {"icon": AppAssets.done, "point": "Access to Classic Form Guide"},
];

bool isSubscribe = false;

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
          child: Text("Current Plan", style: bold(fontSize: 16.sp)),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 26.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.greyColor.withValues(alpha: 0.2),
            ),
          ),
          child: (isSubscribe)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Monthly",
                            style: regular(
                              fontSize: 24.sp,
                              fontFamily: AppFontFamily.secondary,
                            ),
                          ),
                          TextSpan(
                            text: " ‘Pro Punter’",
                            style: regular(
                              fontSize: 24.sp,
                              color: AppColors.premiumYellow,
                              fontFamily: AppFontFamily.secondary,
                            ),
                          ),
                          TextSpan(
                            text: " Account",
                            style: regular(
                              fontSize: 24.sp,
                              fontFamily: AppFontFamily.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    8.h.verticalSpace,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "\$ 9.99 ",
                            style: bold(
                              fontSize: 20.sp,
                              fontFamily: AppFontFamily.primary,
                            ),
                          ),
                          TextSpan(
                            text: "/month",
                            style: semiBold(
                              fontFamily: AppFontFamily.primary,
                              fontSize: 18.sp,
                              color: AppColors.primary.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.h.verticalSpace,
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        Map item = activePlan[i];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageWidget(
                              type: ImageType.svg,
                              path: item["icon"],
                              height: 20.w,
                            ),
                            10.w.horizontalSpace,
                            Text(
                              item["point"],
                              style: regular(fontSize: 16.sp),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => 5.h.verticalSpace,
                      itemCount: activePlan.length,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "Free ‘Mug Punter’ Account",
                      style: regular(
                        fontFamily: AppFontFamily.secondary,
                        fontSize: 24.sp,
                      ),
                    ),
                    Text(
                      "\$ 00.00",
                      style: regular(
                        fontFamily: AppFontFamily.secondary,
                        fontSize: 24.sp,
                      ),
                    ),
                    20.h.verticalSpace,
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        Map item = freePlan[i];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageWidget(
                              type: ImageType.svg,
                              path: item["icon"],
                              height: 20.w,
                            ),
                            10.w.horizontalSpace,
                            Text(
                              item["point"],
                              style: regular(fontSize: 16.sp),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => 5.h.verticalSpace,
                      itemCount: activePlan.length,
                    ),
                  ],
                ),
        ),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            "Billing handled via Apple Store / Google Play",
            style: medium(
              fontSize: 14.sp,
              color: AppColors.greyColor.withValues(alpha: 0.6),
            ),
          ),
        ),
        if (isSubscribe) Spacer(),
        AppFiledButton(
          margin: EdgeInsets.only(bottom: 8.h, left: 25.w, right: 25.w),
          text: "Renew",
          onTap: () {},
        ),

        AppOutlinedButton(
          margin: EdgeInsets.only(bottom: 8.h, left: 25.w, right: 25.w),
          text: "Change Plan",
          onTap: () {},
        ),
        AppOutlinedButton(
          margin: EdgeInsets.only(bottom: 25.h, left: 25.w, right: 25.w),
          text: "Cancel",
          onTap: () {},
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
                      fontSize: 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Manage your Subscription Plan",
                    style: semiBold(
                      fontSize: 14.sp,
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
