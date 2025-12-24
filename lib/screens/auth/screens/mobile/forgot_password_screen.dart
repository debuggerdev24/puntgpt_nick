import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/utils/custom_loader.dart';
import 'package:puntgpt_nick/core/utils/de_bouncing.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';

import '../../../../core/utils/field_validators.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        26.h.verticalSpace,
                        Text(
                          "Forgot Password",
                          style: regular(
                            fontFamily: AppFontFamily.secondary,
                            fontSize: 40.sp,
                          ),
                        ),
                        28.h.verticalSpace,
                        Text(
                          textAlign: TextAlign.center,
                          "We will send you an OTP to the email address you signed up with.",
                          style: regular(
                            fontSize: 16.sp,
                            color: AppColors.primary.withValues(),
                          ),
                        ),
                        26.h.verticalSpace,
                        AppTextField(
                          controller: provider.forgotPasswordCtr,
                          hintText: "Email",
                          validator: FieldValidators().email,
                        ),
                        Spacer(),
                        SafeArea(
                          child: AppFiledButton(
                            margin: EdgeInsets.only(bottom: 20.h),
                            text: "Send OTP",
                            onTap: () {
                              deBouncer.run(() {
                                if (formKey.currentState!.validate()) {
                                  provider.forgotPassword(context: context);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (provider.isForgotPassLoading) FullPageIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
