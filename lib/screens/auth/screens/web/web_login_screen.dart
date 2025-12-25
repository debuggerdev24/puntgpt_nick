import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/core/utils/custom_loader.dart';
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
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final width =
        context.screenWidth *
        ((context.isDesktop)
            ? 0.35
            : (context.isTablet)
            ? 0.45
            : (kIsWeb)
            ? 0.55
            : context.screenWidth);
    return Scaffold(
      appBar: WebTopSection(),
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: (kIsWeb) ? 0 : 25.w,
                    ),
                    child: SizedBox(
                      width: width,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            80.h.verticalSpace,
                            (kIsWeb)
                                ? ImageWidget(
                                    path: AppAssets.splashWebLogo,
                                    type: ImageType.asset,
                                    width: context.isDesktop
                                        ? 375.w
                                        : context.isTablet
                                        ? 550.w
                                        : 750.w,
                                  )
                                : ImageWidget(path: AppAssets.splashAppLogo),
                            18.h.verticalSpace,
                            Text(
                              "'@PuntGPT' the talking from guide",
                              style: regular(
                                fontSize: (context.isDesktop)
                                    ? 24.sp
                                    : (context.isTablet)
                                    ? 34.sp
                                    : (kIsWeb)
                                    ? 46.sp
                                    : 20.sp,
                                fontFamily: AppFontFamily.secondary,
                              ),
                            ),
                            60.h.verticalSpace,
                            AppTextField(
                              controller: provider.loginEmailCtr,
                              validator: FieldValidators().email,
                              hintText: "Email",
                              hintStyle: medium(
                                fontSize: context.isDesktop
                                    ? 16.sp
                                    : context.isTablet
                                    ? 26.sp
                                    : (kIsWeb)
                                    ? 30.sp
                                    : 16.sp,
                                color: AppColors.primary.setOpacity(0.55),
                              ),
                            ),
                            16.h.verticalSpace,
                            AppTextField(
                              controller: provider.loginPasswordCtr,
                              hintText: "Password",
                              validator: (value) {
                                return FieldValidators().required(
                                  value,
                                  "Password",
                                );
                              },
                              onSubmit: () {
                                if (_formKey.currentState!.validate()) {
                                  provider.loginUser(context: context);
                                  return;
                                }
                              },
                              trailingIcon: provider.showLoginPass
                                  ? AppAssets.hide
                                  : AppAssets.show,
                              onTrailingIconTap: () => provider.showLoginPass =
                                  !provider.showLoginPass,
                              hintStyle: medium(
                                fontSize: context.isDesktop
                                    ? 16.sp
                                    : context.isTablet
                                    ? 26.sp
                                    : (kIsWeb)
                                    ? 30.sp
                                    : 16.sp,

                                color: AppColors.primary.setOpacity(0.4),
                              ),
                            ),
                            12.h.verticalSpace,
                            Align(
                              alignment: Alignment.centerRight,
                              child: OnMouseTap(
                                onTap: () {
                                  context.pushNamed(
                                    WebRoutes.forgotPasswordScreen.name,
                                  );
                                  provider.forgotPasswordCtr.clear();
                                },
                                child: Text(
                                  "Forget Password?",
                                  style: bold(
                                    fontSize: context.isDesktop
                                        ? 14.sp
                                        : context.isTablet
                                        ? 24.sp
                                        : (kIsWeb)
                                        ? 28.sp
                                        : 14.sp,
                                  ),
                                ),
                              ),
                            ),
                            40.h.verticalSpace,
                            AppFiledButton(
                              text: "Login",
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  provider.loginUser(context: context);
                                  return;
                                }
                              },
                              textStyle: semiBold(
                                fontSize: context.isDesktop
                                    ? 16.sp
                                    : context.isTablet
                                    ? 26.sp
                                    : (kIsWeb)
                                    ? 30.sp
                                    : 16.sp,
                                color: AppColors.white,
                              ),
                              child:
                                  (provider.isLoginLoading && !context.isMobile)
                                  ? webProgressIndicator(context)
                                  : null,
                            ),
                            18.h.verticalSpace,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "New to PuntGPT? ",
                                  style: medium(
                                    fontSize: context.isDesktop
                                        ? 14.sp
                                        : context.isTablet
                                        ? 18.sp
                                        : (kIsWeb)
                                        ? 22.sp
                                        : 14.sp,
                                    color: AppColors.primary.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                                ),
                                OnMouseTap(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Text(
                                    " Sign up",
                                    style: bold(
                                      fontSize: context.isDesktop
                                          ? 14.sp
                                          : context.isTablet
                                          ? 18.sp
                                          : (kIsWeb)
                                          ? 22.sp
                                          : 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            80.h.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
