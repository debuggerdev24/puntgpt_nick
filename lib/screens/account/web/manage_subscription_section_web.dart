import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/account/web/widgets/subscription_plan_web.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/app_filed_button.dart';
import '../../../provider/account/account_provider.dart';

bool isSubscribe = true;

List freePlan = [
  {"icon": AppAssets.close, "point": "No chat function with PuntGPT"},
  {"icon": AppAssets.close, "point": "No chat function with PuntGPT"},
  {"icon": AppAssets.done, "point": "Limited PuntGPT Search Engine Filters"},
  {"icon": AppAssets.done, "point": "Limited AI analysis of horses"},
  {"icon": AppAssets.done, "point": "Access to Classic Form Guide"},
];

List currentPlan = [
  {"icon": AppAssets.done, "point": "Chat function with PuntGPT"},
  {"icon": AppAssets.done, "point": "Access to PuntGPT Punters Club"},
  {"icon": AppAssets.done, "point": "Full use of PuntGPT Search Engine"},
  {"icon": AppAssets.done, "point": "Access to Classic Form Guide"},
];

class ManageSubscriptionSectionWeb extends StatelessWidget {
  const ManageSubscriptionSectionWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // final sixteenResponsive = context.isDesktop
    //     ? 16.sp
    //     : context.isTablet
    //     ? 24.sp
    //     : (kIsWeb)
    //     ? 28.sp
    //     : 16.sp;
    // final eighteenResponsive = context.isDesktop
    //     ? 18.sp
    //     : context.isTablet
    //     ? 26.sp
    //     : (kIsWeb)
    //     ? 30.sp
    //     : 18.sp;
    // final twentyResponsive = context.isDesktop
    //     ? 20.sp
    //     : context.isTablet
    //     ? 28.sp
    //     : (kIsWeb)
    //     ? 36.sp
    //     : 20.sp;
    final twelveResponsive = context.isDesktop
        ? 12.sp
        : context.isTablet
        ? 20.sp
        : (kIsWeb)
        ? 28.sp
        : 12.sp;
    final fourteenResponsive = context.isDesktop
        ? 14.sp
        : context.isTablet
        ? 22.sp
        : (kIsWeb)
        ? 26.sp
        : 14.sp;
    return Consumer<AccountProvider>(
      builder: (context, provider, child) {
        final plans = provider.plans;
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 10.w, 22.w, 11.w),
                child: topBar(
                  twelveResponsive: twelveResponsive,
                  provider: provider,
                  context: context,
                ),
              ),
              horizontalDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      22.w.verticalSpace,
                      if (provider.showCurrentPlan) ...[
                        Text(
                          "Current Plan : ",
                          style: bold(fontSize: fourteenResponsive),
                        ),
                        12.w.verticalSpace,
                        SubscriptionPlanWeb(
                          plan: plans[0],
                          isCurrentPlan: provider.showCurrentPlan,
                        ),
                      ] else ...[
                        Text(
                          "All Plans : ",
                          style: bold(fontSize: fourteenResponsive),
                        ),
                        12.w.verticalSpace,
                        Wrap(
                          runSpacing: 24.w,
                          spacing: 20.w,
                          children: List.generate(plans.length, (index) {
                            return SubscriptionPlanWeb(
                              plan: plans[index],
                              isCurrentPlan: provider.showCurrentPlan,
                            );
                          }),
                        ),
                        // ...List.generate(plans.length, (index) {
                        //   return SubscriptionPlanWeb(
                        //     plan: plans[index],
                        //     isCurrentPlan: provider.showCurrentPlan,
                        //   );
                        // }),
                      ],

                      //todo subscription box,
                    ],
                  ),
                ),
              ),
              AppFiledButton(
                margin: EdgeInsets.only(
                  top: 20.w,
                  left: 25.w,
                  right: 25.w,
                  bottom: 25.w,
                ),
                text: provider.showCurrentPlan
                    ? "See All Plans"
                    : "See Current Plan",
                onTap: () {
                  provider.setIsShowCurrentPlan = !provider.showCurrentPlan;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Column(
  //                   children: [
  //                     Text(
  //                       "Free ‘Mug Punter’ Account",
  //                       style: regular(
  //                         fontFamily: AppFontFamily.secondary,
  //                         fontSize: 24.sp,
  //                       ),
  //                     ),
  //                     Text(
  //                       "\$ 00.00",
  //                       style: regular(
  //                         fontFamily: AppFontFamily.secondary,
  //                         fontSize: 24.sp,
  //                       ),
  //                     ),
  //                     20.h.verticalSpace,
  //                     points(content: "No chat function with PuntGPT"),
  //                     points(content: "No access to PuntGPT Punters Club"),
  //                     points(
  //                       isBenefit: true,
  //                       content: "Limited PuntGPT Search Engine Filters",
  //                     ),
  //                     points(
  //                       isBenefit: true,
  //                       content: "Limited AI analysis of horses",
  //                     ),
  //                     points(
  //                       isBenefit: true,
  //                       content: "Access to Classic Form Guide",
  //                     ),
  //                   ],
  //                 ),

  Widget points({bool? isBenefit, required String content}) {
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

  Widget topBar({
    required double twelveResponsive,
    required AccountProvider provider,
    required BuildContext context,
  }) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Manage Subscription",
            style: regular(
              fontSize: context.isDesktop ? 24.sp : 30.sp,
              fontFamily: AppFontFamily.secondary,
            ),
          ),
          Text(
            "Manage your Subscription Plan",
            style: semiBold(
              fontSize: twelveResponsive,
              color: AppColors.greyColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
