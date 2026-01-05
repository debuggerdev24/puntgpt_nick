import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({super.key, required this.isFreeSignUp});
  final bool isFreeSignUp;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobileBrowser(context)) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          35.h.verticalSpace,
          isFreeSignUp
              ? Text(
                  "Create Free “Mug Punter” Account",
                  textAlign: TextAlign.center,
                  style: regular(
                    height: 1.2,
                    fontSize: context.isBrowserMobile ? 50.sp : 38.sp,
                    fontFamily: AppFontFamily.secondary,
                  ),
                )
              : RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Create",
                        style: regular(
                          height: 1.2,
                          fontSize: 38.sp,
                          fontFamily: AppFontFamily.secondary,
                        ),
                      ),
                      TextSpan(
                        text: " “Pro Punter” ",
                        style: regular(
                          height: 1.2,
                          fontSize: 38.sp,
                          fontFamily: AppFontFamily.secondary,
                          color: AppColors.premiumYellow,
                        ),
                      ),
                      TextSpan(
                        text: "Account",
                        style: regular(
                          height: 1.2,
                          fontSize: 38.sp,
                          fontFamily: AppFontFamily.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
          20.h.verticalSpace,
          Text(
            textAlign: TextAlign.center,
            isFreeSignUp
                ? "No Payment Details required.*"
                : "Cancel Subscription anytime*",
            style: regular(
              fontSize: context.isBrowserMobile ? 30.sp : 16.sp,
              color: AppColors.primary.setOpacity(0.8),
            ),
          ),
        ],
      );
    } else if (Responsive.isTablet(context)) {
      return SizedBox(
        width: context.screenWidth - 90,
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.h.verticalSpace,
              isFreeSignUp
                  ? Text(
                      "Create Free “Mug Punter” Account",
                      style: regular(
                        height: 1.2,
                        fontSize: 44.sp,
                        fontFamily: AppFontFamily.secondary,
                      ),
                    )
                  : RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Create",
                            style: regular(
                              height: 1.2,
                              fontSize: 44.sp,
                              fontFamily: AppFontFamily.secondary,
                            ),
                          ),
                          TextSpan(
                            text: " “Pro Punter” ",
                            style: regular(
                              height: 1.2,
                              fontSize: 44.sp,
                              fontFamily: AppFontFamily.secondary,
                              color: AppColors.premiumYellow,
                            ),
                          ),
                          TextSpan(
                            text: "Account",
                            style: regular(
                              height: 1.2,
                              fontSize: 38.sp,
                              fontFamily: AppFontFamily.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
              20.h.verticalSpace,
              Text(
                isFreeSignUp
                    ? "No Payment Details required.*"
                    : "Cancel Subscription anytime*",
                style: regular(
                  fontSize: 24.sp,
                  color: AppColors.primary.setOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: context.screenWidth - 90,
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.h.verticalSpace,
              isFreeSignUp
                  ? Text(
                      "Create Free “Mug Punter” Account",
                      style: regular(
                        height: 1.2,
                        fontSize: 38.sp,
                        fontFamily: AppFontFamily.secondary,
                      ),
                    )
                  : RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Create",
                            style: regular(
                              height: 1.2,
                              fontSize: 38.sp,
                              fontFamily: AppFontFamily.secondary,
                            ),
                          ),
                          TextSpan(
                            text: " “Pro Punter” ",
                            style: regular(
                              height: 1.2,
                              fontSize: 38.sp,
                              fontFamily: AppFontFamily.secondary,
                              color: AppColors.premiumYellow,
                            ),
                          ),
                          TextSpan(
                            text: "Account",
                            style: regular(
                              height: 1.2,
                              fontSize: 38.sp,
                              fontFamily: AppFontFamily.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 20),
              Text(
                isFreeSignUp
                    ? "No Payment Details required.*"
                    : "Cancel Subscription anytime*",
                style: regular(
                  fontSize: 16.sp,
                  color: AppColors.primary.setOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
