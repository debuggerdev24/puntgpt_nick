import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class AgeConfirmationScreen extends StatelessWidget {
  const AgeConfirmationScreen({super.key});

  void _onYesTap(BuildContext context) {
    context.go(AppRoutes.onboardingScreen);
  }

  void _onNoTap(BuildContext context) {
    context.go(AppRoutes.onboardingScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? null : WebTopSection(),
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
                  fontSize: 40.sp.flexClamp(30, 40),
                ),
              ),
              if (!Responsive.isMobile(context)) ...[
                SizedBox(height: 50.w.clamp(20, 80)),
                AppFiledButton(
                  onTap: () => _onYesTap(context),
                  text: "Yes",
                  width: 400.w.clamp(200, 500),
                ),
                SizedBox(height: 10),
                AppOutlinedButton(
                  onTap: () => _onNoTap(context),
                  text: "No",
                  width: 400.w.clamp(200, 500),
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
                  AppFiledButton(onTap: () => _onYesTap(context), text: "Yes"),
                  SizedBox(height: 10),
                  AppOutlinedButton(onTap: () => _onNoTap(context), text: "No"),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
