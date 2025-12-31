import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class AgeConfirmationScreen extends StatelessWidget {
  const AgeConfirmationScreen({super.key});

  void _onYesTap(BuildContext context) {
    context.pushNamed(AppRoutes.onboardingScreen.name);
  }

  void _onNoTap(BuildContext context) {
    context.pushNamed(AppRoutes.onboardingScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  fontSize: 40.sp,
                ),
              ),
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
                  10.h.verticalSpace,
                  AppOutlinedButton(onTap: () => _onNoTap(context), text: "No"),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
