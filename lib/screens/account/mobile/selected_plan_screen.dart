import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/models/account/subscription_plan_model.dart';
import 'package:puntgpt_nick/screens/account/mobile/widgets/subscription_plan.dart';

import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';

class SelectedPlanScreen extends StatelessWidget {
  const SelectedPlanScreen({super.key, required this.plan});
  final SubscriptionPlanModel plan;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBar(context: context, planName: plan.plan),
        14.h.verticalSpace,
        SubscriptionPlanMobile(plan: plan),
        Spacer(),
        AppOutlinedButton(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          text: "Cancel",
          onTap: () {
            context.pop();
          },
        ),
        AppFiledButton(
          text: "Pay & Subscribe",
          onTap: () {},
          margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
        ),
      ],
    );
  }

  Widget topBar({required BuildContext context, required String planName}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(23.w, 12.h, 25.w, 14.h),
          child: Row(
            spacing: 8.w,
            children: [
              OnMouseTap(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.arrow_back_ios_rounded, size: 18.h),
              ),
              Expanded(
                child: Text(
                  planName,
                  style: regular(
                    fontSize: (kIsWeb) ? 34.sp : 22.sp,
                    fontFamily: AppFontFamily.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}
