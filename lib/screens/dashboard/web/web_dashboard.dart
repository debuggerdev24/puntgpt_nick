import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/router/web/web_router.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../../../core/constants/text_style.dart';
import '../../../core/widgets/image_widget.dart';
import '../mobile/widgets/dashboard_app_bar.dart';

ValueNotifier<int> indexOfWebTab = ValueNotifier<int>(2);

class WebDashboard extends StatelessWidget {
  const WebDashboard({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    LogHelper.info(
      "is Mobile ${Responsive.isMobile(context)} ${context.screenWidth}",
    );
    LogHelper.info(
      "is Desktop ${Responsive.isDesktop(context)} ${context.screenWidth}",
    );
    LogHelper.info(
      "is Tablet ${Responsive.isTablet(context)} ${context.screenWidth}",
    );
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            DashboardAppBar(navigationShell: navigationShell),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: indexOfWebTab,
                builder: (context, value, child) {
                  return FadeInUp(
                    from: 10,
                    key: ValueKey(value),
                    child: navigationShell,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: (!context.isDesktop)
          ? Container(
              width: context.screenWidth,
              color: AppColors.primary,
              padding: EdgeInsets.fromLTRB(
                15,
                15,
                15,
                context.bottomPadding + 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.w,
                children: [
                  _navItem(
                    onTap: () {
                      indexOfWebTab.value = 0;
                      WebRouter.indexedStackNavigationShell?.goBranch(0);
                    },
                    text: "Subscribe to\nPro Punter",
                    icon: AppAssets.trophy,
                    color: AppColors.premiumYellow,
                    index: 0,
                    context: context,
                  ),
                  _navItem(
                    onTap: () {
                      indexOfWebTab.value = 1;
                      WebRouter.indexedStackNavigationShell?.goBranch(1);
                    },
                    text: "PuntGPT Punter Club",
                    icon: AppAssets.group,

                    hasLock: false,
                    index: 1,
                    context: context,
                  ),
                  _navItem(
                    onTap: () {
                      indexOfWebTab.value = 2;
                      WebRouter.indexedStackNavigationShell?.goBranch(2);
                    },
                    text: "Bookies",
                    icon: AppAssets.bookings,
                    color: AppColors.green,
                    index: 2,
                    context: context,
                  ),
                  _navItem(
                    onTap: () {
                      indexOfWebTab.value = 3;
                      WebRouter.indexedStackNavigationShell?.goBranch(3);
                    },
                    text: "Account",
                    icon: AppAssets.profile,
                    index: 3,
                    context: context,
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  _navItem({
    required VoidCallback onTap,
    required String text,
    required String icon,
    required int index,
    required BuildContext context,
    Color? color,
    bool hasLock = false,
  }) {
    final currentIndex = WebRouter.indexedStackNavigationShell?.currentIndex;
    final opacity = 0.62;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(
              path: icon,
              type: ImageType.svg,
              color:
                  color?.withValues(
                    alpha: currentIndex == index ? 1 : opacity,
                  ) ??
                  AppColors.white.withValues(
                    alpha: currentIndex == index ? 1 : opacity,
                  ),
              height: 32.w.flexClamp(28, 36),
            ),
            // if (hasLock) ...[
            //   Row(
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: 32.w.flexClamp(28, 36),
            //         width: 32.w.flexClamp(28, 36),
            //       ),
            //       ImageWidget(
            //         path: AppAssets.lock,
            //         type: ImageType.svg,
            //         color:
            //         color?.withValues(
            //           alpha: currentIndex == index ? 1 : opacity,
            //         ) ??
            //             AppColors.white.withValues(
            //               alpha: currentIndex == index ? 1 : opacity,
            //             ),
            //         height: 16.w.flexClamp(14, 18),
            //       ),
            //     ],
            //   ),
            // ],
            Text(
              text,
              textAlign: TextAlign.center,
              style: medium(
                fontSize: context.isTablet
                    ? 22.sp
                    : (kIsWeb)
                    ? 26.sp
                    : 12.sp,

                color:
                    color?.withValues(
                      alpha: currentIndex == index ? 1 : opacity,
                    ) ??
                    AppColors.white.withValues(
                      alpha: currentIndex == index ? 1 : opacity,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
