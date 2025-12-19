import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/web/web_router.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/screens/dashboard/web/web_dashboard.dart';

class WebDashboardAppBar extends StatelessWidget {
  const WebDashboardAppBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      height: (context.screenWidth > 1010) ? 92.w : 102.w,
      width: double.maxFinite,
      alignment: AlignmentGeometry.center,
      padding: EdgeInsets.fromLTRB(16.w, 0.h, 90.w, 0.h),
      child: ValueListenableBuilder(
        valueListenable: indexOfWebTab,
        builder: (context, value, child) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 45,
                      width: 170.w,
                      color: AppColors.white,
                      alignment: Alignment.center,
                      child: Text("Ads"),
                    ),
                    60.w.horizontalSpace,
                    //todo -------------------------> Bookies tab
                    _navItem(
                      onTap: () {
                        indexOfWebTab.value = 0;
                        WebRouter.indexedStackNavigationShell!.goBranch(0);
                      },
                      isSelected: 0 == value,
                      text: "Bookies",
                      icon: AppAssets.bookings,
                      color: AppColors.green,
                    ),
                    30.w.horizontalSpace,
                    //todo -------------------------> Punter Club tab
                    _navItem(
                      onTap: () {
                        indexOfWebTab.value = 1;
                        WebRouter.indexedStackNavigationShell!.goBranch(1);
                      },
                      isSelected: 1 == value,
                      text: "PuntGPT\nPunter Club",
                      icon: AppAssets.group,
                    ),
                  ],
                ),
              ),
              Align(alignment: AlignmentGeometry.center, child: _appLogo()),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  spacing: 30.w,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //todo -------------------------> Subscribe to pro punter
                    _navItem(
                      onTap: () {
                        indexOfWebTab.value = 5;
                        context.read<AccountProvider>().setAccountTabIndex = 1;
                        WebRouter.indexedStackNavigationShell!.goBranch(4);
                      },
                      isSelected: 5 == value,
                      text: "Subscribe\nto Pro Punter",
                      icon: AppAssets.trophy,
                      color: AppColors.premiumYellow,
                    ),
                    //todo -------------------------> Tip slip screen
                    _navItem(
                      onTap: () {
                        indexOfWebTab.value = 3;
                        WebRouter.indexedStackNavigationShell!.goBranch(3);
                      },
                      isSelected: 3 == value,
                      child: _tipSlip(),
                    ),
                    //todo -------------------------> Account
                    _navItem(
                      onTap: () {
                        indexOfWebTab.value = 4;
                        context.read<AccountProvider>().setAccountTabIndex = 0;

                        WebRouter.indexedStackNavigationShell!.goBranch(4);
                      },
                      isSelected: 4 == value,
                      text: "Account",
                      icon: AppAssets.profile,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _navItem({
    VoidCallback? onTap,
    String? text,
    String? icon,
    bool? isSelected,
    Widget? child,
    Color? color,
    bool hasLock = false,
  }) {
    return IntrinsicWidth(
      child: Stack(
        alignment: AlignmentGeometry.bottomCenter,

        children: [
          Center(
            child: OnMouseTap(
              onTap: onTap,
              child:
                  child ??
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      if (icon != null)
                        ImageWidget(
                          path: icon,
                          type: ImageType.svg,
                          color: color ?? AppColors.white,
                          height: 32.w.flexClamp(28, 36),
                        ),
                      Text(
                        text!,
                        textAlign: TextAlign.left,
                        style: medium(
                          fontSize: 16.sp,
                          height: 1.5,
                          color: color ?? AppColors.white,
                        ),
                      ),
                    ],
                  ),
            ),
          ),
          (isSelected ?? false)
              ? Container(
                  color: color == AppColors.green
                      ? AppColors.green
                      : color == AppColors.premiumYellow
                      ? AppColors.premiumYellow
                      : Colors.white,
                  height: 4,
                  width: double.infinity,
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _tipSlip() {
    return SizedBox(
      height: (20.sp.flexClamp(18, 22) * 1.2) + 25,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              "Tip Slip",
              style: bold(
                height: 1.2,
                fontSize: 18.sp.flexClamp(16, 20),
                color: AppColors.white,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "10",
                style: semiBold(
                  fontSize: 12.sp.clamp(10, 12),
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appLogo() {
    return OnMouseTap(
      onTap: () {
        WebRouter.indexedStackNavigationShell!.goBranch(2);
        indexOfWebTab.value = 2;
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.w,
        children: [
          ImageWidget(
            type: ImageType.asset,
            path: AppAssets.webLogo,
            color: AppColors.white,
            height: 52.w,
          ),

          Text(
            "PuntGPT",
            style: regular(
              color: AppColors.white,
              fontSize: 22.sp,
              fontFamily: AppFontFamily.secondary,
            ),
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     16.w.verticalSpace,
          //     Text(
          //       "PuntGPT",
          //       style: regular(
          //         height: 0.95,
          //
          //         color: AppColors.white,
          //         fontSize: 22.sp,
          //         fontFamily: AppFontFamily.secondary,
          //       ),
          //     ),
          //     Align(
          //       alignment: AlignmentGeometry.bottomRight,
          //       child: Text(
          //         "Pro",
          //         style: regular(
          //           height: 0.9,
          //           color: AppColors.premiumYellow,
          //           fontSize: 22.sp,
          //           fontFamily: AppFontFamily.secondary,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
