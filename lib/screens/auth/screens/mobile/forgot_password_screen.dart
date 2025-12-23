import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/utils/de_bouncing.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';

import '../../../../core/router/app/app_routes.dart';
import '../../../../core/utils/field_validators.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
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
              AppFiledButton(
                text: "Send OTP",
                onTap: () {
                  deBouncer.run(() {
                    context.pushNamed(AppRoutes.verifyOTPScreen.name);

                    // provider.forgotPassword(context: context);
                  });
                },
              ),
              70.h.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
