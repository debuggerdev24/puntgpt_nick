import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class WebAgeConfirmationScreen extends StatelessWidget {
  const WebAgeConfirmationScreen({super.key});

  void _onYesTap(BuildContext context) {
    context.goNamed(WebRoutes.onBoardingScreen.name);
  }

  void _onNoTap(BuildContext context) {
    context.goNamed(WebRoutes.onBoardingScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WebTopSection(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Are you over 18?",
                textAlign: TextAlign.center,
                style: regular(
                  fontFamily: AppFontFamily.secondary,
                  fontSize: context.isDesktop
                      ? 40.sp
                      : context.isTablet
                      ? 45.sp
                      : (kIsWeb)
                      ? 40.sp
                      : 38.sp,
                ),
              ),
              SizedBox(height: 50.w.clamp(20, 80)),
              if (!Responsive.isMobile(context)) ...[
                OnButtonTap(
                  child: AppFiledButton(
                    onTap: () => _onYesTap(context),
                    text: "Yes",
                    textStyle: semiBold(
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                    width: 400.w.clamp(200, 500),
                  ),
                ),
                10.h.verticalSpace,
                OnButtonTap(
                  child: AppOutlinedButton(
                    onTap: () => _onNoTap(context),
                    text: "No",
                    textStyle: semiBold(fontSize: 16.sp),
                    width: 400.w.clamp(200, 500),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Responsive.isMobile(context)
          ? Padding(
              padding: EdgeInsets.fromLTRB(
                25,
                0,
                25,
                context.bottomPadding + 30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppFiledButton(
                    onTap: () => _onYesTap(context),
                    text: "Yes",
                    textStyle: semiBold(
                      fontSize: 18.sp.flexClamp(16, 20),
                      color: AppColors.white,
                    ),
                  ),
                  10.h.verticalSpace,
                  AppOutlinedButton(
                    onTap: () => _onNoTap(context),
                    text: "No",
                    textStyle: semiBold(fontSize: 18.sp.flexClamp(16, 20)),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
