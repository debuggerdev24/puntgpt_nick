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
        ImageWidget(path: AppAssets.horse, width: 32.w, color: AppColors.white),

        Text(
          "PuntGPT",
          style: regular(
            fontSize: 15,
            fontFamily: AppFontFamily.secondary,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _tipSlip() {
    return SizedBox(
      height: (12.sp.flexClamp(18, 22) * 1.2) + 20,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          context.pushNamed(AppRoutes.tipSlip.name);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Text(
                "Tip Slip",
                style: bold(height: 1.2, fontSize: 20, color: AppColors.white),
              ),
            ),
            Positioned(
              top: 4,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                decoration: BoxDecoration(color: AppColors.white),
                child: Text(
                  "10",
                  style: semiBold(fontSize: 13, color: AppColors.black),
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
      height: 55.h,
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text("Ad", style: regular(fontSize: 16)),
    );
  }
}
