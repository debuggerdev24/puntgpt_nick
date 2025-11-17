import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/utils/field_validators.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.isFreeSignUp});
  final bool isFreeSignUp;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: !kIsWeb ? null : WebTopSection(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Consumer<AuthProvider>(
              builder: (context, provider, _) {
                return SizedBox(
                  width: Responsive.isMobile(context)
                      ? double.maxFinite
                      : 500.w.flexClamp(null, 500),
                  child: Column(
                    children: [
                      120.h.verticalSpace,
                      ImageWidget(path: AppAssets.splashAppLogo),
                      16.h.verticalSpace,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "'@PuntGPT'",
                              style: regular(
                                fontSize: 20.sp,
                                fontFamily: AppFontFamily.secondary,
                              ),
                            ),
                            TextSpan(
                              text: " the talking from guide",
                              style: regular(
                                fontSize: 20.sp,
                                fontFamily: AppFontFamily.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      80.h.verticalSpace,
                      Form(
                        key: _formKey,
                        child: Column(
                          spacing: 8.h,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextField(
                              controller: provider.loginEmailCtr,
                              hintText: "Email",
                              validator: FieldValidators().email,
                            ),
                            AppTextField(
                              controller: provider.loginPasswordCtr,
                              hintText: "Password",
                              obscureText: provider.showLoginPass,
                              validator: FieldValidators().password,
                              trailingIcon: provider.showLoginPass
                                  ? AppAssets.hide
                                  : AppAssets.show,
                              onTrailingIconTap: () => provider.showLoginPass =
                                  !provider.showLoginPass,
                            ),
                          ],
                        ),
                      ),
                      10.h.verticalSpace,
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget Password?",
                          style: bold(fontSize: 14.sp),
                        ),
                      ),
                      100.verticalSpace,
                      AppFiledButton(
                        text: "Login",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.go(AppRoutes.home);

                            return;
                          }
                        },
                      ),
                      15.h.verticalSpace,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "New to PuntGPT? ",
                            style: medium(
                              fontSize: 14.sp,
                              color: AppColors.primary.setOpacity(.8),
                            ),
                          ),
                          OnButtonTap(
                            onTap: () {
                              context.pushReplacement(
                                AppRoutes.signup,
                                extra: {'is_free_sign_up': isFreeSignUp},
                              );
                            },
                            child: Text(" Sign up", style: bold(fontSize: 14.sp)),
                          ),
                        ],
                      ),
                      20.h.verticalSpace,
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
