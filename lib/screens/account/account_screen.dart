import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/text_style.dart';
import '../../core/router/app_router.dart';
import '../../core/widgets/app_devider.dart';

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
            title: "Personal Details",
            onTap: () {
              context.pushNamed(AppRoutes.personalDetails.name);
            },
          ),
          appDivider(),
          accountItem(
            title: "Manage Subscription",
            onTap: () {
              context.pushNamed(AppRoutes.manageSubscription.name);
            },
          ),
        ],
      ),
    );
  }

  Widget accountItem({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: semiBold(fontSize: 20)),
              Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 12.h),
          child: Row(
            spacing: 14.w,
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account",
                    style: regular(
                      fontSize: 24,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Manage your PuntGPT Account",
                    style: semiBold(
                      fontSize: 14,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        appDivider(),
      ],
    );
  }
}
