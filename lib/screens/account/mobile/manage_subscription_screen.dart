import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/screens/account/mobile/subscription_plans_screen.dart';

import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/app_filed_button.dart';
import '../../../core/widgets/app_outlined_button.dart';

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

bool isSubscribe = true;

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, provider, child) {
        return PopScope(
          canPop: provider.showCurrentPlan ? false : true,
          onPopInvokedWithResult: (didPop, result) {
            if (provider.showCurrentPlan) {
              provider.setIsShowCurrentPlan = false;
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topBar(context, provider),
              if (provider.showCurrentPlan)
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.fromLTRB(25.w, 18.h, 0, 0),
              //         child: Text(
              //           "Current Plan",
              //           style: bold(fontSize: (kIsWeb) ? 32.sp : 16.sp),
              //         ),
              //       ),
              //       Container(
              //         margin: EdgeInsets.symmetric(
              //           horizontal: 25.w,
              //           vertical: 12.h,
              //         ),
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 22.w,
              //           vertical: 26.h,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: AppColors.greyColor.withValues(alpha: 0.2),
              //           ),
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             RichText(
              //               text: TextSpan(
              //                 children: [
              //                   TextSpan(
              //                     text: "Monthly",
              //                     style: regular(
              //                       fontSize: (kIsWeb) ? 36.sp : 24.sp,
              //                       fontFamily: AppFontFamily.secondary,
              //                     ),
              //                   ),
              //                   TextSpan(
              //                     text: " ‘Pro Punter’",
              //                     style: regular(
              //                       fontSize: (kIsWeb) ? 36.sp : 24.sp,
              //
              //                       color: AppColors.premiumYellow,
              //                       fontFamily: AppFontFamily.secondary,
              //                     ),
              //                   ),
              //                   TextSpan(
              //                     text: " Account",
              //                     style: regular(
              //                       fontSize: (kIsWeb) ? 36.sp : 24.sp,
              //
              //                       fontFamily: AppFontFamily.secondary,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             8.h.verticalSpace,
              //             RichText(
              //               text: TextSpan(
              //                 children: [
              //                   TextSpan(
              //                     text: "\$ 9.99 ",
              //                     style: bold(
              //                       fontSize: (kIsWeb) ? 32.sp : 20.sp,
              //
              //                       fontFamily: AppFontFamily.primary,
              //                     ),
              //                   ),
              //                   TextSpan(
              //                     text: "/ month",
              //                     style: semiBold(
              //                       fontFamily: AppFontFamily.primary,
              //                       fontSize: (kIsWeb) ? 28.sp : 16.sp,
              //
              //                       color: AppColors.primary.withValues(
              //                         alpha: 0.6,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             16.h.verticalSpace,
              //             ListView.separated(
              //               shrinkWrap: true,
              //               padding: EdgeInsets.all(0),
              //               physics: const NeverScrollableScrollPhysics(),
              //               itemBuilder: (context, i) {
              //                 Map item = activePlan[i];
              //                 return Row(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     ImageWidget(
              //                       type: ImageType.svg,
              //                       path: item["icon"],
              //                       height: (kIsWeb) ? 32.w : 20.w,
              //                     ),
              //                     10.w.horizontalSpace,
              //                     Text(
              //                       item["point"],
              //
              //                       style: regular(
              //                         fontSize: (kIsWeb) ? 28.sp : 16.sp,
              //                       ),
              //                     ),
              //                   ],
              //                 );
              //               },
              //               separatorBuilder: (context, index) =>
              //                   5.h.verticalSpace,
              //               itemCount: activePlan.length,
              //             ),
              //           ],
              //         ),
              //       ),
              //       Center(
              //         child: Text(
              //           textAlign: TextAlign.center,
              //           "Billing handled via Apple Store / Google Play",
              //           style: medium(
              //             fontSize: (kIsWeb) ? 28.sp : 14.sp,
              //             color: AppColors.greyColor.withValues(alpha: 0.6),
              //           ),
              //         ),
              //       ),
              //       // if (isSubscribe) Spacer(),
              //       if (kIsWeb) 40.w.verticalSpace else Spacer(),
              //       AppFiledButton(
              //         margin: EdgeInsets.only(
              //           bottom: 8.w,
              //           left: 25.w,
              //           right: 25.w,
              //         ),
              //         text: "Renew",
              //         textStyle: semiBold(
              //           fontSize: (kIsWeb) ? 30.sp : 18.sp,
              //           color: AppColors.white,
              //         ),
              //         onTap: () {},
              //       ),
              //       AppOutlinedButton(
              //         margin: EdgeInsets.only(
              //           bottom: 8.h,
              //           left: 25.w,
              //           right: 25.w,
              //         ),
              //         text: "Change Plan",
              //         textStyle: semiBold(fontSize: (kIsWeb) ? 30.sp : 18.sp),
              //         onTap: () {},
              //       ),
              //       AppOutlinedButton(
              //         margin: EdgeInsets.only(
              //           bottom: 25.h,
              //           left: 25.w,
              //           right: 25.w,
              //         ),
              //         text: "Cancel",
              //         textStyle: semiBold(fontSize: (kIsWeb) ? 30.sp : 18.sp),
              //         onTap: () {},
              //       ),
              //     ],
              //   ),
              // )
              ...[
                subscriptionPlanMobile(
                  plan: provider.plans[0],
                  isCurrentPlan: provider.showCurrentPlan,
                ),
                if (kIsWeb) 40.w.verticalSpace,
                AppFiledButton(
                  margin: EdgeInsets.only(
                    bottom: 10.h,
                    left: 25.w,
                    right: 25.w,
                  ),
                  text: "Renew",
                  textStyle: semiBold(
                    fontSize: (kIsWeb) ? 30.sp : 18.sp,
                    color: AppColors.white,
                  ),
                  onTap: () {},
                ),
                AppOutlinedButton(
                  margin: EdgeInsets.only(
                    bottom: 10.h,
                    left: 25.w,
                    right: 25.w,
                  ),
                  text: "Change Plan",
                  textStyle: semiBold(fontSize: (kIsWeb) ? 30.sp : 18.sp),
                  onTap: () {},
                ),
                AppOutlinedButton(
                  margin: EdgeInsets.only(
                    bottom: 25.h,
                    left: 25.w,
                    right: 25.w,
                  ),
                  text: "Cancel",
                  textStyle: semiBold(fontSize: (kIsWeb) ? 30.sp : 18.sp),
                  onTap: () {},
                ),
              ] else
                SubscriptionPlansScreen(plans: provider.plans),
            ],
          ),
        );
      },
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

  Widget topBar(BuildContext context, AccountProvider provider) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5.w, 12.h, 25.w, 16.h),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Logger.info("showCurrentPlan ; ${provider.showCurrentPlan}");
                  if (provider.showCurrentPlan) {
                    provider.setIsShowCurrentPlan = false;
                    return;
                  }
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
                      fontSize: (kIsWeb) ? 36.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Manage your Subscription Plan",
                    style: semiBold(
                      fontSize: (kIsWeb) ? 28.sp : 14.sp,
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
