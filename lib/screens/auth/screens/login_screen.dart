import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/utils/field_validators.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/provider/auth_provider.dart';
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
                      50.verticalSpace,
                      ImageWidget(path: AppAssets.splashAppLogo),
                      SizedBox(height: 12),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "'@PuntGPT'",
                              style: bold(fontSize: 20.sp.flexClamp(18, 22)),
                            ),
                            TextSpan(
                              text: " the talking from guide",
                              style: bold(fontSize: 20.sp.flexClamp(18, 22)),
                            ),
                          ],
                        ),
                      ),
                      50.verticalSpace,
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextField(
                              controller: provider.loginEmailCtr,
                              hintText: "Email",
                              validator: FieldValidators().email,
                            ),
                            SizedBox(height: 8),
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
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget Password?",
                          style: bold(fontSize: 14.sp.flexClamp(12, 16)),
                        ),
                      ),
                      80.verticalSpace,
                      AppFiledButton(
                        text: "Login",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {}
                          context.go(AppRoutes.home);
                        },
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "New to PuntGPT? ",
                            style: medium(
                              fontSize: 14.sp.flexClamp(12, 16),
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
                            child: Text(
                              " Sign up",
                              style: bold(fontSize: 14.sp.flexClamp(12, 16)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
