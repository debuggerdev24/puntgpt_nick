import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/web/web_router.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/screens/dashboard/web/web_dashboard.dart';

class WebDashboardAppBar extends StatelessWidget {
  const WebDashboardAppBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 90.w, 0.h),
      child: Stack(
        alignment: Alignment.center,
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
                  onTap: () {},
                  isSelected: 0 == indexOfWebTab.value,

                  text: "Bookies",
                  icon: AppAssets.bookings,
                  color: AppColors.green,
                ),
                30.w.horizontalSpace,
                //todo -------------------------> Punter Club tab
                _navItem(
                  onTap: () {
                    WebRouter.indexedStackNavigationShell!.goBranch(1);
                    indexOfWebTab.value = 1;
                  },
                  isSelected: 1 == indexOfWebTab.value,
                  text: "PuntGPT\nPunter Club",
                  icon: AppAssets.group,
                ),
              ],
            ),
          ),
          _appLogo(),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              spacing: 30.w,
              mainAxisSize: MainAxisSize.min,
              children: [
                //todo -------------------------> Subscribe to pro punter
                _navItem(
                  onTap: () {},
                  isSelected: 2 == indexOfWebTab.value,
                  text: "Subscribe\nto Pro Punter",
                  icon: AppAssets.trophy,
                  color: AppColors.premiumYellow,
                ),
                _navItem(onTap: () {}, text: ""),
                _tipSlip(),
                //todo -------------------------> Account
                _navItem(
                  onTap: () {
                    indexOfWebTab.value = 3;
                    WebRouter.indexedStackNavigationShell!.goBranch(3);
                  },
                  isSelected: 3 == indexOfWebTab.value,
                  text: "Account",
                  icon: AppAssets.profile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipSlip() {
    return OnMouseTap(
      onTap: () {
        WebRouter.indexedStackNavigationShell!.goBranch(2);
      },
      child: SizedBox(
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
      ),
    );
  }

  Widget _appLogo() {
    return OnMouseTap(
      onTap: () {
        WebRouter.indexedStackNavigationShell!.goBranch(0);
        indexOfWebTab.value = -1;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            type: ImageType.asset,
            path: AppAssets.appBarLogo,
            color: AppColors.white,
          ),
          // Text(
          //   "Pro",
          //   style: regular(
          //     fontSize: 14.sp,
          //     fontFamily: AppFontFamily.secondary,
          //     color: AppColors.premiumYellow,
          //   ),
          // ),
        ],
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          11.w.verticalSpace,
          child ??
              OnMouseTap(
                onTap: onTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: [
                    ImageWidget(
                      path: icon!,
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
          24.w.verticalSpace,
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: (isSelected ?? false)
                ? Container(
                    color: Colors.white,
                    height: 3,
                    width: double.infinity,
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
