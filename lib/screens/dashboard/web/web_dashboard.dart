import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/router/web/web_router.dart';
import 'package:puntgpt_nick/main.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/dashboard/web/widgets/web_dashboard_app_bar.dart';
import 'package:puntgpt_nick/screens/offline/widget/offline_view.dart';

import '../../../core/constants/text_style.dart';
import '../../../core/widgets/image_widget.dart';
import '../../../core/widgets/on_button_tap.dart';
import '../../../provider/account/account_provider.dart';
import '../../../provider/search_engine_provider.dart';

ValueNotifier<int> indexOfWebTab = ValueNotifier<int>(2);

class WebDashboard extends StatelessWidget {
  const WebDashboard({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    Logger.info(
      "is Mobile ${Responsive.isMobile(context)} ${context.screenWidth}",
    );
    Logger.info(
      "is Desktop ${Responsive.isDesktop(context)} ${context.screenWidth}",
    );
    Logger.info(
      "is Tablet ${Responsive.isTablet(context)} ${context.screenWidth}",
    );
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ValueListenableBuilder<bool>(
          valueListenable: isNetworkConnected,
          builder: (context, value, child) {
            if (value) {
              return Consumer<SearchEngineProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      WebDashboardAppBar(navigationShell: navigationShell),
                      Expanded(
                        child: Stack(
                          children: [
                            ValueListenableBuilder<int>(
                              valueListenable: indexOfWebTab,
                              builder: (context, value, child) {
                                return FadeInUp(
                                  from: 10,
                                  key: ValueKey(value),
                                  child: navigationShell,
                                );
                              },
                            ),
                            //todo menu bar
                            if (provider.isMenuOpen && !context.isDesktop)
                              _buildMenuPanel(context, provider),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return offlineView();
          },
        ),
      ),
    );
  }

  Widget _appLogo(BuildContext context) {
    return OnMouseTap(
      onTap: () {
        WebRouter.indexedStackNavigationShell!.goBranch(2);
        indexOfWebTab.value = 2;
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: context.isTablet ? 20.w : 28.w,

        children: [
          ImageWidget(
            type: ImageType.asset,
            path: AppAssets.webLogo,
            color: AppColors.white,
            height: context.isTablet ? 42.w : 58.w,
          ),

          Text(
            "Dashboard",

            style: regular(
              color: AppColors.white,
              fontSize: context.isTablet ? 22.sp : 35.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuPanel(BuildContext context, SearchEngineProvider provider) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: context.isTablet ? 24.w : 30.w,
        children: [
          _menuItem(
            onTap: () {
              WebRouter.indexedStackNavigationShell!.goBranch(2);
              indexOfWebTab.value = 2;
              provider.setIsMenuOpen = false;
            },
            child: Row(children: [_appLogo(context)]),
            text: "Subscribe to Pro Punter",
            icon: AppAssets.trophy,
            index: 5,
            context: context,
          ),
          _menuItem(
            onTap: () {
              indexOfWebTab.value = 5;
              context.read<AccountProvider>().setAccountTabIndex = 1;
              WebRouter.indexedStackNavigationShell!.goBranch(4);
              provider.setIsMenuOpen = false;
            },
            text: "Subscribe to Pro Punter",
            icon: AppAssets.trophy,
            color: AppColors.premiumYellow,
            index: 5,
            context: context,
          ),
          _menuItem(
            onTap: () {
              indexOfWebTab.value = 1;
              WebRouter.indexedStackNavigationShell?.goBranch(1);
              provider.setIsMenuOpen = false;
            },
            text: "PuntGPT Punter Club",
            icon: AppAssets.group,
            index: 1,
            context: context,
          ),
          _menuItem(
            onTap: () {
              indexOfWebTab.value = 0;
              WebRouter.indexedStackNavigationShell!.goBranch(0);
              provider.setIsMenuOpen = false;
            },
            text: "Bookies",
            icon: AppAssets.bookings,
            color: AppColors.green,
            index: 0,
            context: context,
          ),
          _menuItem(
            onTap: () {
              indexOfWebTab.value = 4;
              context.read<AccountProvider>().setAccountTabIndex = 0;

              WebRouter.indexedStackNavigationShell!.goBranch(4);
              provider.setIsMenuOpen = false;
            },
            text: "Account",
            icon: AppAssets.profile,
            index: 4,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required VoidCallback onTap,
    required String text,
    required String icon,
    required int index,
    required BuildContext context,
    Widget? child,
    Color? color,
  }) {
    final currentIndex = WebRouter.indexedStackNavigationShell?.currentIndex;
    final isSelected = currentIndex == index;

    return OnMouseTap(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? (color ?? AppColors.white).withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child:
            child ??
            Row(
              spacing: context.isTablet ? 20.w : 28.w,
              children: [
                ImageWidget(
                  path: icon,
                  type: ImageType.svg,
                  color: color ?? AppColors.white,
                  height: context.isTablet ? 42.w : 58.w,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: medium(
                      fontSize: context.isTablet ? 22.sp : 35.sp,
                      color: color ?? AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }

  // _navItem({
  //   required VoidCallback onTap,
  //   required String text,
  //   required String icon,
  //   required int index,
  //   required BuildContext context,
  //   Color? color,
  //   bool hasLock = false,
  // }) {
  //   final currentIndex = WebRouter.indexedStackNavigationShell?.currentIndex;
  //   final opacity = 0.62;
  //   return Expanded(
  //     child: GestureDetector(
  //       behavior: HitTestBehavior.opaque,
  //       onTap: onTap,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           ImageWidget(
  //             path: icon,
  //             type: ImageType.svg,
  //             color:
  //                 color?.withValues(
  //                   alpha: currentIndex == index ? 1 : opacity,
  //                 ) ??
  //                 AppColors.white.withValues(
  //                   alpha: currentIndex == index ? 1 : opacity,
  //                 ),
  //             height: 32.w.flexClamp(28, 36),
  //           ),
  //           // if (hasLock) ...[
  //           //   Row(
  //           //     mainAxisSize: MainAxisSize.min,
  //           //     crossAxisAlignment: CrossAxisAlignment.start,
  //           //     children: [
  //           //       SizedBox(
  //           //         height: 32.w.flexClamp(28, 36),
  //           //         width: 32.w.flexClamp(28, 36),
  //           //       ),
  //           //       ImageWidget(
  //           //         path: AppAssets.lock,
  //           //         type: ImageType.svg,
  //           //         color:
  //           //         color?.withValues(
  //           //           alpha: currentIndex == index ? 1 : opacity,
  //           //         ) ??
  //           //             AppColors.white.withValues(
  //           //               alpha: currentIndex == index ? 1 : opacity,
  //           //             ),
  //           //         height: 16.w.flexClamp(14, 18),
  //           //       ),
  //           //     ],
  //           //   ),
  //           // ],
  //           Text(
  //             text,
  //             textAlign: TextAlign.center,
  //             style: medium(
  //               fontSize: context.isTablet
  //                   ? 22.sp
  //                   : (kIsWeb)
  //                   ? 26.sp
  //                   : 12.sp,
  //
  //               color:
  //                   color?.withValues(
  //                     alpha: currentIndex == index ? 1 : opacity,
  //                   ) ??
  //                   AppColors.white.withValues(
  //                     alpha: currentIndex == index ? 1 : opacity,
  //                   ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  //   bottomNavigationBar: (!context.isDesktop)
  //   ? Container(
  //   width: context.screenWidth,
  //   color: AppColors.primary,
  //   padding: EdgeInsets.fromLTRB(
  //   15,
  //   15,
  //   15,
  //   context.bottomPadding + 15,
  //   ),
  //   child: Row(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   spacing: 15.w,
  //   children: [
  //   _navItem(
  //   onTap: () {
  //   indexOfWebTab.value = 0;
  //   WebRouter.indexedStackNavigationShell?.goBranch(0);
  //   },
  //   text: "Subscribe to\nPro Punter",
  //   icon: AppAssets.trophy,
  //   color: AppColors.premiumYellow,
  //   index: 0,
  //   context: context,
  //   ),
  //   _navItem(
  //   onTap: () {
  //   indexOfWebTab.value = 1;
  //   WebRouter.indexedStackNavigationShell?.goBranch(1);
  //   },
  //   text: "PuntGPT Punter Club",
  //   icon: AppAssets.group,
  //
  //   hasLock: false,
  //   index: 1,
  //   context: context,
  //   ),
  //   _navItem(
  //   onTap: () {
  //   indexOfWebTab.value = 2;
  //   WebRouter.indexedStackNavigationShell?.goBranch(2);
  //   },
  //   text: "Bookies",
  //   icon: AppAssets.bookings,
  //   color: AppColors.green,
  //   index: 2,
  //   context: context,
  //   ),
  //   _navItem(
  //   onTap: () {
  //   indexOfWebTab.value = 3;
  //   WebRouter.indexedStackNavigationShell?.goBranch(3);
  //   },
  //   text: "Account",
  //   icon: AppAssets.profile,
  //   index: 3,
  //   context: context,
  //   ),
  //   ],
  //   ),
  //   )
  //       : SizedBox(),
}
