import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';

import '../../../../../core/widgets/app_check_box.dart';
import '../../../../../core/widgets/on_button_tap.dart';
import '../../../../../responsive/responsive_builder.dart';

class WebSignUpBottomSection extends StatelessWidget {
  const WebSignUpBottomSection({
    super.key,
    required this.onLoginTap,
    required this.onSignUpTap,
    required this.provider,
  });

  final VoidCallback onLoginTap;
  final VoidCallback onSignUpTap;
  final AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Responsive.isMobile(context)
                ? double.maxFinite
                : context.screenWidth * 0.6.flexClamp(null, 600),
            child: AppCheckBox(
              value: provider.isReadTermsAndConditions,
              onChanged: (value) {
                provider.isReadTermsAndConditions = value;
              },
              label: Text(
                "I have read and accept the Terms & Conditions, AI disclaimer and understand my personal information will be handled in accordance with the Privacy Policy.",
                style: regular(
                  fontSize: (context.isDesktop)
                      ? 14.sp
                      : (context.isTablet)
                      ? 22.sp
                      : (kIsWeb)
                      ? 30.sp
                      : 14.sp,
                  height: 1.2,
                  color: AppColors.primary.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
          60.h.verticalSpace,

          AppFiledButton(
            text: "Create Account",
            width: (context.isDesktop)
                ? 400.w
                : (context.isTablet)
                ? 500.w
                : 600.w,
            onTap: onSignUpTap,
            textStyle: semiBold(
              fontSize: (context.isDesktop)
                  ? 16.sp
                  : (context.isTablet)
                  ? 24.sp
                  : (kIsWeb)
                  ? 30.sp
                  : 18.sp, //(kIsWeb) ? 28.sp : 18.sp,
              color: AppColors.white,
            ),
          ),
          20.h.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Already Registered?",
                style: regular(
                  fontSize: (context.isDesktop)
                      ? 14.sp
                      : (context.isTablet)
                      ? 22.sp
                      : (kIsWeb)
                      ? 28.sp
                      : 14.sp,
                  color: AppColors.primary.withValues(alpha: 0.8),
                ),
              ),
              OnMouseTap(
                onTap: onLoginTap,
                child: Text(
                  " Login",
                  style: bold(
                    fontSize: (context.isDesktop)
                        ? 14.sp
                        : (context.isTablet)
                        ? 22.sp
                        : (kIsWeb)
                        ? 28.sp
                        : 14.sp,
                  ),
                ),
              ),
            ],
          ),
          60.h.verticalSpace,
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                "Terms & Conditions",
                style: bold(
                  fontSize: (context.isDesktop)
                      ? 12.sp
                      : (context.isTablet)
                      ? 20.sp
                      : (kIsWeb)
                      ? 22.sp
                      : 14.sp,
                ),
              ),
              Container(
                width: 1,
                height: 20.h,
                color: AppColors.primary,
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),
              Text(
                "AI disclaimer",
                style: bold(
                  fontSize: (context.isDesktop)
                      ? 12.sp
                      : (context.isTablet)
                      ? 20.sp
                      : (kIsWeb)
                      ? 22.sp
                      : 14.sp,
                ),
              ),
              Container(
                width: 1,
                height: 20.h,
                color: AppColors.primary,
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),
              Text(
                "Privacy Policy",
                style: bold(
                  fontSize: (context.isDesktop)
                      ? 12.sp
                      : (context.isTablet)
                      ? 20.sp
                      : (kIsWeb)
                      ? 22.sp
                      : 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
