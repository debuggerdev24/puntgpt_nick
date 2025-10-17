import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_check_box.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/features/auth/screens/widget/sign_up_bottom_section.dart';
import 'package:puntgpt_nick/features/auth/screens/widget/sign_up_form.dart';
import 'package:puntgpt_nick/features/auth/screens/widget/sign_up_title.dart';
import 'package:puntgpt_nick/provider/auth_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.isFreeSignUp});
  final bool isFreeSignUp;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Column(
              children: [
                SignUpTitle(isFreeSignUp: isFreeSignUp),
                SizedBox(height: 20),
                SignUpForm(formKey: _formKey),
                SizedBox(height: 12),
                Consumer<AuthProvider>(
                  builder: (context, provider, _) {
                    return SizedBox(
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
                            fontSize: 14.sp.clamp(12, 16),
                            height: 1.2,
                            color: AppColors.primary.setOpacity(0.8),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                SignUpBottomSection(
                  onLoginTap: () {
                    context.pushReplacement(
                      AppRoutes.login,
                      extra: {"is_free_sign_up": isFreeSignUp},
                    );
                  },
                  onSignUpTap: () {
                    if (_formKey.currentState!.validate()) {
                      
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
