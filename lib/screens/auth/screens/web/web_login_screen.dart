import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/utils/field_validators.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../../../../core/constants/text_style.dart';
import '../../../../core/widgets/image_widget.dart';
import '../../../../core/widgets/on_button_tap.dart';

class WebLoginScreen extends StatelessWidget {
  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth * 0.35;
    return Scaffold(
      appBar: WebTopSection(),
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: SizedBox(
                width: width,
                child: Column(
                  children: [
                    80.h.verticalSpace,
                    ImageWidget(
                      path: AppAssets.splashWebLogo,
                      type: ImageType.asset,
                      width: context.isDesktop
                          ? 375.w
                          : context.isTablet
                          ? 550.w
                          : 600.w,
                    ),
                    18.h.verticalSpace,
                    Text(
                      "'@PuntGPT' the talking from guide",
                      style: regular(
                        fontSize: 24.sp,
                        fontFamily: AppFontFamily.secondary,
                      ),
                    ),
                    60.h.verticalSpace,
                    AppTextField(
                      controller: provider.loginEmailCtr,
                      validator: FieldValidators().email,
                      hintText: "Email",
                      hintStyle: medium(
                        fontSize: context.isTablet ? 22.sp : 16.sp,
                        color: AppColors.primary.setOpacity(0.4),
                      ),
                    ),
                    16.h.verticalSpace,
                    AppTextField(
                      controller: provider.loginEmailCtr,
                      hintText: "Password",
                      validator: FieldValidators().password,
                      trailingIcon: provider.showLoginPass
                          ? AppAssets.hide
                          : AppAssets.show,
                      onTrailingIconTap: () =>
                          provider.showLoginPass = !provider.showLoginPass,
                      hintStyle: medium(
                        fontSize: context.isTablet ? 22.sp : 16.sp,
                        color: AppColors.primary.setOpacity(0.4),
                      ),
                    ),
                    12.h.verticalSpace,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget Password?",
                        style: bold(fontSize: 16.sp),
                      ),
                    ),
                    40.h.verticalSpace,
                    AppFiledButton(
                      text: "Login",
                      onTap: () {},
                      textStyle: semiBold(
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    ),
                    18.h.verticalSpace,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "New to PuntGPT? ",
                          style: medium(
                            fontSize: 14.sp,
                            color: AppColors.primary.withValues(alpha: 0.8),
                          ),
                        ),
                        OnButtonTap(
                          onTap: () {
                            context.pop();
                          },
                          child: Text(" Sign up", style: bold(fontSize: 14.sp)),
                        ),
                      ],
                    ),
                    80.h.verticalSpace,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
