import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/features/onboarding/widgets/plans.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Video area fills remaining height
            SizedBox(height: 40),
            Container(
              height: 200.w.flexClamp(200, 250),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary.setOpacity(0.2)),
              ),
              alignment: Alignment.center,
              child: Text(
                "Video",
                style: regular(
                  fontSize: 32.sp.flexClamp(28, 35),
                  fontFamily: AppFontFamily.secondary,
                ),
              ),
            ),

            SizedBox(height: 40.w.flexClamp(35, 40)),
            Plans(),
          ],
        ),
      ),
    );
  }
}
