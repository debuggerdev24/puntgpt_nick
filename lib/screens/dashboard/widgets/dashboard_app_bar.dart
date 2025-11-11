import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/dashboard/widgets/web_dashboard_app_bar.dart';

class DashboardAppBar extends StatefulWidget {
  const DashboardAppBar({super.key});

  @override
  State<DashboardAppBar> createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !Responsive.isDesktop(context)
        ? Container(
            decoration: BoxDecoration(color: AppColors.primary),
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _appLogo(),
                Expanded(child: _bannerAd()),
                _tipSlip(),
              ],
            ),
          )
        : WebDashboardAppBar();
  }

  Widget _appLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageWidget(
          type: ImageType.asset,
          path: AppAssets.appBarLogo,
          color: AppColors.white,
          // height: 50.w.flexClamp(45, 55),
        ),
        // Text(
        //   "Pro",
        //   style: regular(
        //     fontSize: 14.sp.flexClamp(12, 16),
        //     fontFamily: AppFontFamily.secondary,
        //     color: AppColors.premiumYellow,
        //   ),
        // ),
      ],
    );
  }

  Widget _tipSlip() {
    return SizedBox(
      height: (20.sp.flexClamp(18, 22) * 1.2) + 25,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          context.pushNamed(AppRoutes.tipSlip.name);
        },
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
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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

  Widget _bannerAd() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text("Ad", style: regular(fontSize: 12.sp)),
    );
  }
}
