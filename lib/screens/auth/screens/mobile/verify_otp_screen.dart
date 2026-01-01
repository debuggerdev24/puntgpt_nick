import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/utils/custom_loader.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_style.dart';
import '../../../../core/widgets/app_filed_button.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      26.h.verticalSpace,
                      Text(
                        "Verify OTP",
                        style: regular(
                          fontFamily: AppFontFamily.secondary,
                          fontSize: (kIsWeb) ? 60.sp : 40.sp,
                        ),
                      ),
                      28.h.verticalSpace,
                      Text(
                        textAlign: TextAlign.center,
                        "Enter the OTP received on your registered email address to reset password.",
                        style: regular(
                          fontSize: (kIsWeb) ? 30.sp : 16.sp,

                          color: AppColors.primary.withValues(),
                        ),
                      ),
                      28.h.verticalSpace,
                      //todo otp field
                      Pinput(
                        controller: provider.otpCtr,
                        length: 4,

                        separatorBuilder: (index) =>
                            (context.isMobile && kIsWeb)
                            ? 28.w.horizontalSpace
                            : 14.w.horizontalSpace,
                        defaultPinTheme: PinTheme(
                          height: (kIsWeb) ? 80.w : 55.h,
                          width: (kIsWeb) ? 80.w : 70.w,
                          textStyle: medium(fontSize: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.1),
                            ),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          height: (kIsWeb) ? 80.w : 55.h,
                          width: (kIsWeb) ? 80.w : 70.w,

                          // textStyle: medium(fontSize: 20.sp),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              width: 2,
                            ),
                          ),
                        ),
                        submittedPinTheme: PinTheme(
                          height: (kIsWeb) ? 80.w : 55.h,
                          width: (kIsWeb) ? 80.w : 70.w,
                          textStyle: regular(
                            fontSize: (kIsWeb) ? 35.sp : 30.sp,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onCompleted: (code) {},
                      ),
                      Spacer(),
                      //todo bottom buttons
                      Text(
                        "Didn’t receive OTP?",
                        style: semiBold(fontSize: (kIsWeb) ? 28.sp : 14.sp),
                      ),
                      AppOutlinedButton(
                        text: "Re-Send",
                        onTap: () {},
                        textStyle: (kIsWeb) ? semiBold(fontSize: 30.sp) : null,
                        margin: EdgeInsets.only(top: 10.h, bottom: 12.h),
                      ),
                      SafeArea(
                        child: AppFiledButton(
                          margin: EdgeInsets.only(bottom: 20.h),
                          text: "Reset Password",
                          textStyle: (kIsWeb)
                              ? semiBold(
                                  fontSize: 30.sp,
                                  color: AppColors.white,
                                )
                              : null,
                          onTap: () {
                            provider.verifyOtp(context: context);
                            // context.pushNamed(AppRoutes.resetPasswordScreen.name);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (provider.isVerifyOtpLoading) FullPageIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
