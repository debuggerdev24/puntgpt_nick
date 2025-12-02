import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/router/app/app_router.dart';
import '../../../core/widgets/app_devider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        AppRouter.indexedStackNavigationShell?.goBranch(0);
      },
      child: Column(
        children: [
          topBar(context),
          accountItem(
            context: context,
            title: "Personal Details",
            onTap: () {
              if (kIsWeb) {
                context.pushNamed(WebRoutes.personalDetailsScreen.name);
                return;
              }
              context.pushNamed(AppRoutes.personalDetailsScreen.name);
            },
          ),
          horizontalDivider(),
          accountItem(
            context: context,
            title: "Manage Subscription",
            onTap: () {
              if (kIsWeb) {
                context.pushNamed(WebRoutes.manageSubscriptionScreen.name);
                return;
              }
              context.pushNamed(AppRoutes.manageSubscriptionScreen.name);
            },
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Terms & Conditions",
                  style: bold(fontSize: (kIsWeb) ? 30.sp : 14.sp),
                ),
                Container(
                  width: 1,
                  height: 12,
                  color: AppColors.primary,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                Text(
                  "AI disclaimer",
                  style: bold(fontSize: (kIsWeb) ? 30.sp : 14.sp),
                ),
                Container(
                  width: 1,
                  height: 12,
                  color: AppColors.primary,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                Text(
                  "Privacy Policy",
                  style: bold(fontSize: (kIsWeb) ? 30.sp : 14.sp),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text("Terms & Conditions", style: bold(fontSize: 14.sp)),
            //     Text(" | ", style: bold(fontSize: 14.sp)),
            //     Text("AI Disclaimer", style: bold(fontSize: 14.sp)),
            //     Text(" | ", style: bold(fontSize: 14.sp)),
            //     Text("Terms & Conditions", style: bold(fontSize: 14.sp)),
            //   ],
            // ),
          ),
          26.h.verticalSpace,
        ],
      ),
    );
  }

  Widget accountItem({
    required String title,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return OnMouseTap(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: (kIsWeb) ? 38.w : 25.w,
          vertical: 18.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: semiBold(fontSize: (kIsWeb) ? 32.sp : 18.sp)),
            Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
      ),
    );
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5.w, 12.h, 25.w, 16.h),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  AppRouter.indexedStackNavigationShell!.goBranch(0);
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
              ),
              // GestureDetector(
              //   onTap: () {
              //     context.pop();
              //   },
              //   child: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account",
                    style: regular(
                      fontSize: (kIsWeb) ? 40.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Manage your PuntGPT Account",
                    style: semiBold(
                      fontSize: (kIsWeb) ? 26.sp : 14.sp,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}
