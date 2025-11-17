import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';

class WebDashboardAppBar extends StatelessWidget {
  const WebDashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 45, width: 120, color: AppColors.white),
                SizedBox(width: 30),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageWidget(
                      path: AppAssets.bookings,
                      type: ImageType.svg,
                      height: 32.w.flexClamp(30, 35),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Bookies",
                      style: semiBold(
                        fontSize: 14.sp.flexClamp(12, 16),
                        height: 1.2,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _appLogo(),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              spacing: 15,
              mainAxisSize: MainAxisSize.min,
              children: [
                _navItem(
                  onTap: () {},
                  text: "Subscribe\nto Pro Punter",
                  icon: AppAssets.trophy,
                  color: AppColors.premiumYellow,
                ),
                _tipSlip(),
                _navItem(
                  onTap: () {},
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            type: ImageType.asset,
            path: AppAssets.appBarLogo,
            color: AppColors.white,
            // height: 50.w.flexClamp(45, 55),
          ),
          Text(
            "Pro",
            style: regular(
              fontSize: 14.sp,
              fontFamily: AppFontFamily.secondary,
              color: AppColors.premiumYellow,
            ),
          ),
        ],
      ),
    );
  }

  _navItem({
    required VoidCallback onTap,
    required String text,
    required String icon,
    Color? color,
    bool hasLock = false,
  }) {
    return OnButtonTap(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              ImageWidget(
                path: icon,
                type: ImageType.svg,
                color: color ?? AppColors.white,
                height: 32.w.flexClamp(28, 36),
              ),
              if (hasLock) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32.w.flexClamp(28, 36),
                      width: 32.w.flexClamp(28, 36),
                    ),
                    ImageWidget(
                      path: AppAssets.lock,
                      type: ImageType.svg,
                      color: color ?? AppColors.white,
                      height: 16.w.flexClamp(14, 18),
                    ),
                  ],
                ),
              ],
            ],
          ),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: medium(
                fontSize: 14.sp,
                height: 1.2,
                color: color ?? AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
