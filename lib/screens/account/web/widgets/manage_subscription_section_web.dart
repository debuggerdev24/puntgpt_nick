import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_style.dart';
import '../../../../core/widgets/app_devider.dart';
import '../../../../core/widgets/image_widget.dart';
import '../../../../provider/account/account_provider.dart';

bool isSubscribe = false;

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
    double subscriptionBoxWidth = context.isDesktop ? 340.w : 510.w;
    final sixteenResponsive = context.isDesktop
        ? 16.sp
        : context.isTablet
        ? 24.sp
        : (kIsWeb)
        ? 28.sp
        : 16.sp;
    final eighteenResponsive = context.isDesktop
        ? 18.sp
        : context.isTablet
        ? 26.sp
        : (kIsWeb)
        ? 30.sp
        : 18.sp;
    final twentyResponsive = context.isDesktop
        ? 20.sp
        : context.isTablet
        ? 28.sp
        : (kIsWeb)
        ? 36.sp
        : 20.sp;
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
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 11.h, 22.w, 11.w),
                child: topBar(
                  twelveResponsive: twelveResponsive,
                  provider: provider,
                  context: context,
                ),
              ),
              horizontalDivider(),
              22.h.verticalSpace,
              Column(
                spacing: 12.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Plan:",
                    style: bold(fontSize: fourteenResponsive),
                  ),
                  //todo subscription box,
                  Container(
                    width: subscriptionBoxWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 25.w,
                    ),
                    margin: EdgeInsets.only(bottom: 28.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
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
                                        fontSize: twentyResponsive,
                                        fontFamily: AppFontFamily.secondary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " ‘Pro Punter’",
                                      style: regular(
                                        fontSize: twentyResponsive,
                                        color: AppColors.premiumYellow,
                                        fontFamily: AppFontFamily.secondary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Account",
                                      style: regular(
                                        fontSize: twentyResponsive,
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
                                        fontSize: twentyResponsive,
                                        fontFamily: AppFontFamily.primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "/month",
                                      style: semiBold(
                                        fontFamily: AppFontFamily.primary,
                                        fontSize: fourteenResponsive,
                                        color: AppColors.primary.withValues(
                                          alpha: 0.6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              16.h.verticalSpace,
                              //todo points
                              ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  Map item = currentPlan[i];
                                  return Row(
                                    spacing: 8.w,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ImageWidget(
                                        type: ImageType.svg,
                                        path: item["icon"],
                                        height: context.isDesktop
                                            ? 20.w
                                            : context.isTablet
                                            ? 28.w
                                            : (kIsWeb)
                                            ? 36.w
                                            : 20.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          item["point"],
                                          style: regular(
                                            fontSize: fourteenResponsive,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    5.h.verticalSpace,
                                itemCount: currentPlan.length,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Free ‘Mug Punter’ Account",
                                style: regular(
                                  fontFamily: AppFontFamily.secondary,
                                  fontSize: twentyResponsive,
                                ),
                              ),
                              Text(
                                "\$ 00.00",
                                style: bold(fontSize: twentyResponsive),
                              ),
                              20.h.verticalSpace,
                              ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  Map item = freePlan[i];
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ImageWidget(
                                        type: ImageType.svg,
                                        path: item["icon"],
                                        height: context.isDesktop
                                            ? 20.w
                                            : context.isTablet
                                            ? 28.w
                                            : (kIsWeb)
                                            ? 36.w
                                            : 20.w,
                                      ),
                                      10.w.horizontalSpace,
                                      Expanded(
                                        child: Text(
                                          item["point"],
                                          style: regular(
                                            fontSize: fourteenResponsive,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    5.h.verticalSpace,
                                itemCount: freePlan.length,
                              ),
                            ],
                          ),
                  ),
                  if (isSubscribe) ...[
                    //todo renew button
                    AppFiledButton(
                      text: "Renew",
                      width: subscriptionBoxWidth,
                      textStyle: bold(
                        fontSize: fourteenResponsive,
                        color: AppColors.white,
                      ),
                      onTap: () {},
                    ),
                    //todo change plan button
                    AppOutlinedButton(
                      text: "Change Plan",
                      width: subscriptionBoxWidth,
                      textStyle: bold(fontSize: fourteenResponsive),
                      onTap: () {},
                    ),

                    //todo cancel button
                    AppOutlinedButton(
                      text: "Cancel",
                      width: subscriptionBoxWidth,
                      textStyle: bold(fontSize: fourteenResponsive),
                      onTap: () {},
                    ),
                  ] else
                    AppFiledButton(
                      text: "Upgrade to Pro",
                      width: subscriptionBoxWidth,
                      textStyle: bold(
                        fontSize: fourteenResponsive,
                        color: AppColors.white,
                      ),
                      onTap: () {},
                    ),
                ],
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
              height: 1,
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
