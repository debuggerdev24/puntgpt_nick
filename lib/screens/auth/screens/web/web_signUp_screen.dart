import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/screens/auth/screens/web/widgets/web_sign_up_form.dart';
import 'package:puntgpt_nick/screens/auth/screens/web/widgets/web_signup_bottom.dart';

import '../../../../core/router/app/app_routes.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/de_bouncing.dart';
import '../../../../provider/auth/auth_provider.dart';
import '../../../../responsive/responsive_builder.dart';
import '../mobile/widgets/sign_up_title.dart';

class WebSignUpScreen extends StatelessWidget {
  const WebSignUpScreen({super.key, required this.isFreeSignUp});
  final bool isFreeSignUp;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: WebTopSection(),
      body: Container(
        alignment: Responsive.isMobile(context)
            ? Alignment.topLeft
            : Alignment.topCenter,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 30),
          child: Consumer<AuthProvider>(
            builder: (context, provider, child) => Column(
              children: [
                Stack(
                  children: [
                    Center(child: SignUpTitle(isFreeSignUp: isFreeSignUp)),
                    Padding(
                      padding: EdgeInsets.only(
                        left: (context.isDesktop) ? 35.w : 12.w,
                        top: (kIsWeb) ? 30.h : 14.h,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: OnButtonTap(
                          onTap: () {
                            context.pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: context.isDesktop ? 22.w : 28.w,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () => context.pop(),
                        //   child: ImageWidget(
                        //     type: ImageType.svg,
                        //     path: AppAssets.back,
                        //
                        //     width: 80.w.flexClamp(30, 40),
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
                50.h.verticalSpace,
                WebSignUpForm(formKey: formKey),
                20.h.verticalSpace,
                WebSignUpBottomSection(
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
                  provider: provider,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
