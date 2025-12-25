import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/core/utils/app_toast.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/screens/auth/screens/web/widgets/web_sign_up_form.dart';
import 'package:puntgpt_nick/screens/auth/screens/web/widgets/web_signup_bottom.dart';

import '../../../../core/utils/custom_loader.dart';
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
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) => Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 30.w),

                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: OnMouseTap(
                            onTap: () {
                              AppToast.success(
                                context: context,
                                message: "dfjkvjkjkjk",
                              );
                            },
                            child: SignUpTitle(isFreeSignUp: isFreeSignUp),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: (context.isDesktop) ? 35.w : 12.w,
                            top: (kIsWeb) ? 30.h : 14.h,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: OnMouseTap(
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
                        // LogHelper.info(Responsive.isDesktop(context))
                        provider.clearLoginControllers();
                        context.pushNamed(WebRoutes.logInScreen.name);
                      },
                      onSignUpTap: () {
                        deBouncer.run(() {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          provider.registerUser(
                            context: context,
                            isFreeSignUp: isFreeSignUp,
                          );
                        });
                      },

                      provider: provider,
                    ),
                  ],
                ),
              ),

              if (provider.isSignUpLoading) FullPageIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
