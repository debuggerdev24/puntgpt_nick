import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/utils/app_toast.dart';
import 'package:puntgpt_nick/core/utils/de_bouncing.dart';
import 'package:puntgpt_nick/core/widgets/app_check_box.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/auth/screens/widget/sign_up_bottom_section.dart';
import 'package:puntgpt_nick/screens/auth/screens/widget/sign_up_form.dart';
import 'package:puntgpt_nick/screens/auth/screens/widget/sign_up_title.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.isFreeSignUp});
  final bool isFreeSignUp;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: !kIsWeb ? null : WebTopSection(),
      body: SafeArea(
        child: Container(
          alignment: Responsive.isMobile(context)
              ? Alignment.topLeft
              : Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 30),
            child: Consumer<AuthProvider>(
              builder: (context, provider, child) => Column(
                children: [
                  SignUpTitle(isFreeSignUp: isFreeSignUp),
                  20.h.verticalSpace,
                  SignUpForm(formKey: formKey),
                  12.h.verticalSpace,
                  // Consumer<AuthProvider>(
                  //   builder: (context, provider, _) {
                  //     return
                  //   },
                  // ),
                  SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.maxFinite
                        : context.screenWidth * 0.8.flexClamp(null, 800),
                    child: AppCheckBox(
                      value: provider.isReadTermsAndConditions,
                      onChanged: (value) {
                        provider.isReadTermsAndConditions = value;
                      },
                      label: Text(
                        "I have read and accept the Terms & Conditions, AI disclaimer and understand my personal information will be handled in accordance with the Privacy Policy.",
                        style: regular(
                          fontSize: 14,
                          height: 1.2,
                          color: AppColors.primary.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ),
                  30.h.verticalSpace,
                  SignUpBottomSection(
                    onLoginTap: () {
                      context.pushReplacement(
                        AppRoutes.login,
                        extra: {"is_free_sign_up": isFreeSignUp},
                      );
                    },
                    onSignUpTap: () {
                      deBouncer.run(() {
                        if (formKey.currentState!.validate() &&
                            provider.isReadTermsAndConditions) {
                          // if () {}
                          // context.pushReplacement(
                          //   AppRoutes.login,
                          //   extra: {"is_free_sign_up": isFreeSignUp},
                          // );
                          return;
                        }
                        AppToast.warning(
                          context: context,
                          message:
                              "Please check the box to agree to the terms and continue.",
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
