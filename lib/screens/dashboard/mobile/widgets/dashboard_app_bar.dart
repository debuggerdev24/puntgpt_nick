import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/router/web/web_router.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class DashboardAppBar extends StatefulWidget {
  const DashboardAppBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<DashboardAppBar> createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  @override
  Widget build(BuildContext context) {
    return //!context.isDesktop
    // ?
    Container(
      decoration: BoxDecoration(color: AppColors.primary),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: (kIsWeb) ? 40.w : 16.w,
        vertical: 8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_appLogo(), _bannerAd(), _tipSlip()],
      ),
    );
    // : WebDashboardAppBar(navigationShell: widget.navigationShell);
  }

  Widget _appLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageWidget(
          path: AppAssets.horse,
          width: context.isTablet
              ? 55.sp
              : (kIsWeb)
              ? 62.w
              : 32.w,
          color: AppColors.white,
        ),
        Text(
          "PuntGPT",
          style: regular(
            fontSize: context.isTablet
                ? 32.sp
                : (kIsWeb)
                ? 48.sp
                : 16.sp,
            fontFamily: AppFontFamily.secondary,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _tipSlip() {
    return SizedBox(
      height: (12.h.flexClamp(18, 22) * 1.2) + 20,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (kIsWeb) {
            WebRouter.indexedStackNavigationShell!.goBranch(2);
            return;
          }

          context.pushNamed(AppRoutes.tipSlipScreen.name);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Text(
                "Tip Slip",
                style: bold(
                  height: 1.2,
                  fontSize: context.isTablet
                      ? 32.sp
                      : (kIsWeb)
                      ? 40.sp
                      : 20.sp,
                  color: AppColors.white,
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: (kIsWeb) ? 3 : 1,
                ),
                decoration: BoxDecoration(color: AppColors.white),
                child: Text(
                  "10",
                  style: semiBold(
                    fontSize: context.isTablet
                        ? 18.sp
                        : (kIsWeb)
                        ? 24.sp
                        : 12.sp,
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
    return Expanded(
      child: Container(
        height: 55.h,
        margin: EdgeInsets.symmetric(horizontal: (kIsWeb) ? 200.w : 20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text("Ad", style: regular(fontSize: (kIsWeb) ? 30.sp : 16.sp)),
      ),
    );
  }
}
