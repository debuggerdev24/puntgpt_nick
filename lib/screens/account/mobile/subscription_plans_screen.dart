import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/models/account/subscription_plan_model.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_filed_button.dart';
import '../../../core/widgets/image_widget.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key, required this.plans});
  final List<SubscriptionPlanModel> plans;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ...List.generate(plans.length, (index) {
            final plan = plans[index];
            return subscriptionPlanMobile(plan: plan, isCurrentPlan: false);
          }),

          Spacer(),
          AppFiledButton(
            margin: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 20.h),
            text: "See Current Plan",
            textStyle: semiBold(
              fontSize: (kIsWeb) ? 30.sp : 18.sp,
              color: AppColors.white,
            ),
            onTap: () {
              context.read<AccountProvider>().setIsShowCurrentPlan = true;
            },
          ),
        ],
      ),
    );
  }

  Widget paymentDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "Monthly",
              style: regular(
                fontSize: 20.sp,
                fontFamily: AppFontFamily.secondary,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\$ 9.99 ",
                    style: bold(
                      fontSize: 16.sp,
                      fontFamily: AppFontFamily.primary,
                    ),
                  ),
                  TextSpan(
                    text: "/month",
                    style: bold(
                      fontFamily: AppFontFamily.primary,
                      fontSize: 12.sp,
                      color: AppColors.primary.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,

              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Yearly",
                  style: regular(
                    fontSize: 20.sp,
                    fontFamily: AppFontFamily.secondary,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Text(" (50% OFF)", style: bold(fontSize: 12.sp)),
                ),
              ],
            ),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\$ 59.99 ",
                    style: bold(
                      fontSize: 16.sp,
                      fontFamily: AppFontFamily.primary,
                    ),
                  ),
                  TextSpan(
                    text: "/month",
                    style: bold(
                      fontFamily: AppFontFamily.primary,
                      fontSize: 12.sp,
                      color: AppColors.primary.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Lifetime",
              style: regular(
                fontSize: 20.sp,
                fontFamily: AppFontFamily.secondary,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\$ 24 ",
                    style: bold(
                      fontSize: 16.sp,
                      fontFamily: AppFontFamily.primary,
                    ),
                  ),
                  TextSpan(
                    text: "one off",
                    style: bold(
                      fontFamily: AppFontFamily.primary,
                      fontSize: 12.sp,
                      color: AppColors.primary.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget subscriptionPlanMobile({
  required SubscriptionPlanModel plan,
  required bool isCurrentPlan,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.greyColor.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: plan.id == 1
                    ? "Free"
                    : plan.id == 2
                    ? "Monthly"
                    : plan.id == 3
                    ? "Yearly"
                    : "Lifetime",
                style: regular(
                  fontSize: (kIsWeb) ? 37.sp : 24.sp,
                  fontFamily: AppFontFamily.secondary,
                ),
              ),
              TextSpan(
                text: plan.id == 1 ? "  ‘Mug Punter’ " : "  ‘Pro Punter’ ",
                style: regular(
                  fontSize: (kIsWeb) ? 37.sp : 24.sp,

                  color: plan.id == 1
                      ? AppColors.primary
                      : AppColors.premiumYellow,
                  fontFamily: AppFontFamily.secondary,
                ),
              ),
              TextSpan(
                text: " Account",
                style: regular(
                  fontSize: (kIsWeb) ? 36.sp : 24.sp,

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
                text: (plan.id == 1)
                    ? "\$ ${int.parse(plan.price).toStringAsFixed(2)} "
                    : "\$ ${plan.price} ",
                style: bold(
                  fontSize: (kIsWeb) ? 33.sp : 20.sp,
                  fontFamily: AppFontFamily.primary,
                ),
              ),

              if (plan.id != 4)
                TextSpan(
                  text: "/ ${plan.durationLabel}",
                  style: semiBold(
                    fontFamily: AppFontFamily.primary,
                    fontSize: (kIsWeb) ? 29.sp : 16.sp,
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
            // Map item = activePlan[i];
            final features = plan.features;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWidget(
                  type: ImageType.svg,
                  path: (plan.id == 1 && i < 2)
                      ? AppAssets.close
                      : AppAssets.done,
                  height: (kIsWeb) ? 32.w : 20.w,
                ),
                (kIsWeb) ? 14.w.horizontalSpace : 10.w.horizontalSpace,
                Expanded(
                  child: Text(
                    features[i],
                    style: regular(fontSize: (kIsWeb) ? 28.sp : 16.sp),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => 5.h.verticalSpace,
          itemCount: plan.features.length,
        ),
      ],
    ),
  );
}
