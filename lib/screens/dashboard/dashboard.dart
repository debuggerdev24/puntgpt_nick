import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/screens/dashboard/widgets/dashboard_app_bar.dart';

import '../../core/router/app_router.dart';
import '../home/home_screen.dart';

final GlobalKey<_DashboardState> dashboardKey = GlobalKey<_DashboardState>();
ValueNotifier<int> indexOfTab = ValueNotifier(0);
List<Widget> pages = [HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen()];

class Dashboard extends StatefulWidget {
  Dashboard({required this.navigationShell}) : super(key: dashboardKey);

  final StatefulNavigationShell navigationShell;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            DashboardAppBar(),

            // Expanded(child: pages[value]),
            Expanded(child: widget.navigationShell),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
                    AppRouter.indexedStackNavigationShell?.goBranch(0);
                  },
                  text: "Subscribe to\nPro Punter",
                  icon: AppAssets.trophy,
                  color: AppColors.premiumYellow,
                  index: 0,
                ),
                _navItem(
                  onTap: () {},
                  text: "PuntGPT Punter Club",
                  icon: AppAssets.group,
                  hasLock: true,
                  index: 1,
                ),
                _navItem(
                  onTap: () {},
                  text: "Bookies",
                  icon: AppAssets.bookings,
                  color: AppColors.green,
                  index: 2,
                ),
                _navItem(
                  onTap: () {
                    AppRouter.indexedStackNavigationShell?.goBranch(1);
                  },
                  text: "Account",
                  icon: AppAssets.profile,
                  index: 3,
                ),
              ],
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
    required int index,
    Color? color,
    bool hasLock = false,
  }) {
    log(AppRouter.indexedStackNavigationShell!.currentIndex.toString());
    final currentIndex = AppRouter.indexedStackNavigationShell?.currentIndex;
    final opacity = 0.65;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
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
                        color:
                            color?.withValues(
                              alpha: currentIndex == index ? 1 : opacity,
                            ) ??
                            AppColors.white.withValues(
                              alpha: currentIndex == index ? 1 : opacity,
                            ),
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
                textAlign: TextAlign.center,
                style: medium(
                  fontSize: 10,
                  color:
                      color?.withValues(
                        alpha: currentIndex == index ? 1 : opacity,
                      ) ??
                      AppColors.white.withValues(
                        alpha: currentIndex == index ? 1 : opacity,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
