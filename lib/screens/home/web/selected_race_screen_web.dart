import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/provider/search_engine_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/home/web/widgets/home_screen_tab_web.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';
import '../mobile/widgets/home_screen_tab.dart';

class SelectedRaceTableScreenWeb extends StatelessWidget {
  const SelectedRaceTableScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.isMobile
        ? double.maxFinite
        : context.isTablet
        ? 1200.w
        : 1100.w;
    return Consumer<SearchEngineProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          width: bodyWidth,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (kIsWeb) ...[
              70.h.verticalSpace,
              HomeScreenTabWeb(selectedIndex: provider.selectedTab),
            ] else ...[
              20.h.verticalSpace,
              HomeScreenTab(selectedIndex: provider.selectedTab),
            ],
            SizedBox(
                width: bodyWidth,
                child: topBar(context: context,width: bodyWidth))
          ],
                ),
        );
      },
    );
  }
  Widget topBar({required BuildContext context, required width}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(6.w, 25.h, 25.w, 20.h),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Flemington",
                    style: regular(
                      fontSize: 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "PuntGPT Legends Stakes 3200m. Date. Time",
                    style: semiBold(
                      fontSize: 14.sp,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        appDivider(),
      ],
    );
  }

}
