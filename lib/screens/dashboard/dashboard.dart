import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/dashboard/widgets/dashboard_app_bar.dart';

final GlobalKey<_DashboardState> dashboardKey = GlobalKey<_DashboardState>();

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
            Expanded(child: widget.navigationShell),
          ],
        ),
      ),

      bottomNavigationBar: !Responsive.isDesktop(context)
          ? Column(
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
                    spacing: 15.w.flexClamp(12, 18),
                    children: [
                      _navItem(
                        onTap: () {},
                        text: "Subscribe to\nPro Punter",
                        icon: AppAssets.trophy,
                        color: AppColors.premiumYellow,
                      ),
                      _navItem(
                        onTap: () {},
                        text: "PuntGPT Punter Club",
                        icon: AppAssets.group,
                        hasLock: true,
                      ),
                      _navItem(
                        onTap: () {},
                        text: "Bookies",
                        icon: AppAssets.bookings,
                      ),
                      _navItem(
                        onTap: () {},
                        text: "Account",
                        icon: AppAssets.profile,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }

  _navItem({
    required VoidCallback onTap,
    required String text,
    required String icon,
    Color? color,
    bool hasLock = false,
  }) {
    return Expanded(
      child: OnButtonTap(
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
                  color: color ?? AppColors.white.setOpacity(.4),
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
                        color: color ?? AppColors.white.setOpacity(.4),
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
                  fontSize: 10.sp.flexClamp(8, 12),
                  color: color ?? AppColors.white.setOpacity(.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
