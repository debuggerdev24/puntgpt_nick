import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class SignUpBottomSection extends StatelessWidget {
  const SignUpBottomSection({
    super.key,
    required this.onLoginTap,
    required this.onSignUpTap,
  });

  final VoidCallback onLoginTap;
  final VoidCallback onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Already Registered?",
              style: regular(
                fontSize: 14.sp.clamp(12, 16),
                color: AppColors.primary.setOpacity(0.8),
              ),
            ),
            OnButtonTap(
              onTap: onLoginTap,
              child: Text(" Login", style: bold(fontSize: 14.sp.clamp(12, 16))),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          width: Responsive.isMobile(context)
              ? double.maxFinite
              : 500.w.flexClamp(null, 500),
          child: AppFiledButton(text: "Create Account", onTap: onSignUpTap),
        ),
        SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Terms & Conditions",
              style: bold(fontSize: 14.sp.flexClamp(12, 16)),
            ),
            Container(
              width: 1,
              height: 20,
              color: AppColors.primary,
              margin: EdgeInsets.symmetric(horizontal: 10),
            ),
            Text(
              "AI disclaimer",
              style: bold(fontSize: 14.sp.flexClamp(12, 16)),
            ),
            Container(
              width: 1,
              height: 20,
              color: AppColors.primary,
              margin: EdgeInsets.symmetric(horizontal: 10),
            ),
            Text(
              "Privacy Policy",
              style: bold(fontSize: 14.sp.flexClamp(12, 16)),
            ),
          ],
        ),
      ],
    );
  }
}
