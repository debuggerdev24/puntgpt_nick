import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({super.key, required this.isFreeSignUp});
  final bool isFreeSignUp;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: Responsive.isMobile(context)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          isFreeSignUp
              ? Text(
                  "Create Free “Mug Punter” Account",
                  style: regular(
                    height: 1.2,
                    fontSize: 38.sp.flexClamp(36, 40),
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
                          fontSize: 38.sp.flexClamp(36, 40),
                          fontFamily: AppFontFamily.secondary,
                        ),
                      ),
                      TextSpan(
                        text: " “Pro Punter” ",
                        style: regular(
                          height: 1.2,
                          fontSize: 38.sp.flexClamp(36, 40),
                          fontFamily: AppFontFamily.secondary,
                          color: AppColors.premiumYellow,
                        ),
                      ),
                      TextSpan(
                        text: "Account",
                        style: regular(
                          height: 1.2,
                          fontSize: 38.sp.flexClamp(36, 40),
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
              fontSize: 16.sp.clamp(14, 18),
              color: AppColors.primary.setOpacity(0.8),
            ),
          ),
        ],
      );
    } else {
      if (Responsive.isDesktop(context)) {
        return SizedBox(
          width: context.screenWidth - 90,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    isFreeSignUp
                        ? Text(
                            "Create Free “Mug Punter” Account",
                            style: regular(
                              height: 1.2,
                              fontSize: 38.sp.flexClamp(36, 40),
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
                                    fontSize: 38.sp.flexClamp(36, 40),
                                    fontFamily: AppFontFamily.secondary,
                                  ),
                                ),
                                TextSpan(
                                  text: " “Pro Punter” ",
                                  style: regular(
                                    height: 1.2,
                                    fontSize: 38.sp.flexClamp(36, 40),
                                    fontFamily: AppFontFamily.secondary,
                                    color: AppColors.premiumYellow,
                                  ),
                                ),
                                TextSpan(
                                  text: "Account",
                                  style: regular(
                                    height: 1.2,
                                    fontSize: 38.sp.flexClamp(36, 40),
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
                        fontSize: 16.sp.clamp(14, 18),
                        color: AppColors.primary.setOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              if (!Responsive.isMobile(context))
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: ImageWidget(
                      type: ImageType.svg,
                      path: AppAssets.back,
                      height: 40.w.flexClamp(30, 40),
                      width: 40.w.flexClamp(30, 40),
                    ),
                  ),
                ),
            ],
          ),
        );
      } else {
        return Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: ImageWidget(
                  type: ImageType.svg,
                  path: AppAssets.back,
                  height: 40.w.flexClamp(30, 40),
                  width: 40.w.flexClamp(30, 40),
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                isFreeSignUp
                    ? Text(
                        "Create Free “Mug Punter” Account",
                        style: regular(
                          height: 1.2,
                          fontSize: 38.sp.flexClamp(36, 40),
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
                                fontSize: 38.sp.flexClamp(36, 40),
                                fontFamily: AppFontFamily.secondary,
                              ),
                            ),
                            TextSpan(
                              text: " “Pro Punter” ",
                              style: regular(
                                height: 1.2,
                                fontSize: 38.sp.flexClamp(36, 40),
                                fontFamily: AppFontFamily.secondary,
                                color: AppColors.premiumYellow,
                              ),
                            ),
                            TextSpan(
                              text: "Account",
                              style: regular(
                                height: 1.2,
                                fontSize: 38.sp.flexClamp(36, 40),
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
                    fontSize: 16.sp.clamp(14, 18),
                    color: AppColors.primary.setOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        );
      }
    }
  }
}
