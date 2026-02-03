import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';

class TipSlipScreen extends StatelessWidget {
  const TipSlipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBar(context),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
            child: Column(
              children: [
                tipSlipItem(context: context),
                tipSlipItem(context: context),
                tipSlipItem(context: context),
                tipSlipItem(context: context),

                AppFilledButton(
                  margin: EdgeInsets.only(top: 24.h, bottom: 12.h),
                  text: "Play Fantasy Picks (4)",
                  textStyle: semiBold(fontSize: 16.sixteenSp(context),color: AppColors.white),
                  onTap: () {},
                ),

                Text(
                  "Upgrade to Pro Punter",
                  style: bold(fontSize: 14.fourteenSp(context), color: AppColors.premiumYellow),
                ),
                Spacer(),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Use Code: ",
                        style: bold(
                          fontSize: 14.fourteenSp(context),
                          fontFamily: AppFontFamily.primary,
                        ),
                      ),
                      TextSpan(
                        text: "‘PUNTGPT’",
                        style: bold(
                          fontSize: 14.fourteenSp(context),
                          color: Color(0xffE5B82E),
                          fontFamily: AppFontFamily.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget tipSlipItem({required BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(border: Border.all(color: AppColors.primary)),
      child: Row(
        children: [
          //todo -----------> check box
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: AppColors.primary,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 16),
          ),
          context.isBrowserMobile ? 90.w.horizontalSpace : 15.w.horizontalSpace,

          //* -----------> title
          Text("8. Delicacy", style: semiBold(fontSize: context.isBrowserMobile ? 34.sp : 20.sp)),
          10.horizontalSpace,
          Icon(Icons.keyboard_arrow_down_rounded),
          Spacer(),
          Text("\$8.50", style: bold(fontSize: context.isBrowserMobile ? 34.sp : 20.sp)),
        ],
      ),
    );
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25.w, 22.h, 25.w, 22.h),
          child: Row(
            spacing: 14.w,
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
              ),
              Text(
                "Tip Slip",
                style: regular(
                  fontSize: (context.isBrowserMobile) ? 48.sp : 24.sp,
                  fontFamily: AppFontFamily.secondary,
                  height: 1.35,
                ),
              ),

              25.h.verticalSpace,
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}
