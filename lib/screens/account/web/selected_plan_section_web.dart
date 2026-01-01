import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/account/web/widgets/subscription_plan_web.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/utils/custom_loader.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/app_filed_button.dart';
import '../../../core/widgets/app_outlined_button.dart';
import '../../../provider/account/account_provider.dart';

class SelectedPlanSectionWeb extends StatelessWidget {
  const SelectedPlanSectionWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final fourteenResponsive = context.isDesktop ? 14.sp : 22.sp;
    double subscriptionBoxWidth = context.isDesktop ? 340.w : 510.w;

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
                  twelveResponsive: context.isDesktop ? 12.sp : 20.sp,
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
                      //todo show current plan
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
                        //todo shows button for the current plans
                        //todo renew button
                        AppFiledButton(
                          margin: EdgeInsets.only(top: 20.w),
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
                          margin: EdgeInsets.symmetric(vertical: 10.w),
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
                      ]
                      //todo show selected plan for purchase
                      else if (provider.showSelectedPlan) ...[
                        SubscriptionPlanWeb(
                          plan: plans
                              .where((e) => e.id == provider.selectedPlanId)
                              .first,
                          isCurrentPlan: provider.showCurrentPlan,
                        ),
                        AppFiledButton(
                          margin: EdgeInsets.only(
                            top: context.isDesktop ? 24.w : 34.w,
                            left: 24.w,
                            right: 24.w,
                          ),
                          width: context.isDesktop ? 320.w : 380.w,
                          text: "Save",
                          onTap: () {},
                          textStyle: semiBold(
                            fontSize: context.isDesktop ? 16.sp : 21.5.sp,
                            color: AppColors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: context.isDesktop ? 12.w : 16.5.w,
                          ),
                          child: (provider.isUpdateProfileLoading)
                              ? webProgressIndicator(context)
                              : null,
                        ),
                      ]
                      //todo show the all plans
                      else ...[
                        Text(
                          "All Plans : ",
                          style: bold(fontSize: fourteenResponsive),
                        ),
                        12.w.verticalSpace,
                        Wrap(
                          runSpacing: 24.w,
                          spacing: 20.w,
                          children: List.generate(plans.length, (index) {
                            return OnMouseTap(
                              onTap: () {
                                provider.setIsShowSelectedPlan(
                                  showSelectedPlan: true,
                                  planIndex: plans[index].id,
                                );
                              },
                              child: SubscriptionPlanWeb(
                                plan: plans[index],
                                isCurrentPlan: provider.showCurrentPlan,
                              ),
                            );
                          }),
                        ),
                        if (context.isDesktop)
                          14.w.verticalSpace
                        else
                          20.w.verticalSpace,
                      ],
                      //todo subscription box,
                    ],
                  ),
                ),
              ),

              AppFiledButton(
                margin: EdgeInsets.only(
                  // top: 20.w,
                  left: 60.w,
                  right: 60.w,
                  bottom: 25.w,
                ),

                text: provider.showCurrentPlan
                    ? "See All Plans"
                    : "See Current Plan",
                textStyle: semiBold(
                  fontSize: context.isDesktop ? 17.sp : 22.sp,
                  color: AppColors.white,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: context.isDesktop ? 12.w : 16.5.w,
                ),
                onTap: () {
                  if (provider.showSelectedPlan) {
                    provider.setIsShowSelectedPlan(
                      showSelectedPlan: false,
                      planIndex: 1,
                    );
                  }
                  provider.setIsShowCurrentPlan = !provider.showCurrentPlan;
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
