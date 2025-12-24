import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/utils/app_toast.dart';
import 'package:puntgpt_nick/core/utils/custom_loader.dart';
import 'package:puntgpt_nick/core/utils/field_validators.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_style.dart';
import '../../../../core/widgets/app_filed_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) => Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      28.h.verticalSpace,
                      Text(
                        "Reset Password",
                        style: regular(
                          fontFamily: AppFontFamily.secondary,
                          fontSize: 40.sp,
                        ),
                      ),
                      28.h.verticalSpace,
                      Text(
                        textAlign: TextAlign.center,
                        "Enter new password below to reset.",
                        style: regular(
                          fontSize: 16.sp,
                          color: AppColors.primary.withValues(),
                        ),
                      ),
                      55.h.verticalSpace,
                      AppTextField(
                        controller: provider.newPasswordCtr,
                        hintText: "New Password",
                        validator: FieldValidators().password,
                      ),
                      15.h.verticalSpace,
                      AppTextField(
                        controller: provider.resetConfirmPasswordCtr,
                        hintText: "Confirm Password",
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (provider.newPasswordCtr.text.trim() !=
                                provider.resetConfirmPasswordCtr.text.trim()) {
                              return "Confirm Password should match with new Password!";
                            }
                          }

                          return FieldValidators().required(
                            value,
                            "Confirm Password",
                          );
                        },
                      ),
                      Spacer(),
                      SafeArea(
                        child: AppFiledButton(
                          margin: EdgeInsets.only(bottom: 20.h),
                          text: "Confirm",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              provider.resetPassword(
                                onSuccess: () {
                                  context.goNamed(AppRoutes.loginScreen.name);
                                  AppToast.success(
                                    context: context,
                                    message:
                                        "Your password has been reset successfully.",
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // if (provider.isResetPasswordLoading) FullPageIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
