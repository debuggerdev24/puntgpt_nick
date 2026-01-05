import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/provider/punt_club/punter_club_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/punt_gpt_club/web/widgets/club_chat_screen_web.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/on_button_tap.dart';
import '../../home/web/home_screen_web.dart';

class PunterClubScreenWebScreen extends StatelessWidget {
  const PunterClubScreenWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.isBrowserMobile
        ? double.maxFinite
        : context.isTablet
        ? 1240.w
        : 1040.w;
    final twentyResponsive = context.isDesktop
        ? 20.sp
        : context.isTablet
        ? 28.sp
        : (context.isBrowserMobile)
        ? 36.sp
        : 20.sp;
    // final sixteenResponsive = context.isDesktop
    //     ? 16.sp
    //     : context.isTablet
    //     ? 24.sp
    //     : (context.isBrowserMobile)
    //     ? 32.sp
    //     : 16.sp;
    // final twelveResponsive = context.isDesktop
    //     ? 12.sp
    //     : context.isTablet
    //     ? 20.sp
    //     : (kIsWeb)
    //     ? 28.sp
    //     : 12.sp;
    final fourteenResponsive = context.isDesktop
        ? 14.sp
        : context.isTablet
        ? 20.sp
        : (context.isBrowserMobile)
        ? 28.sp
        : 14.sp;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: bodyWidth,
              child: Consumer<PunterClubProvider>(
                builder: (context, provider, child) {
                  return Row(
                    children: [
                      //todo ---------------> left panel
                      verticalDivider(),
                      SizedBox(
                        width: context.isDesktop
                            ? 312.w
                            : context.isTablet
                            ? 370.w
                            : 512.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //todo title
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.isDesktop ? 26.w : 20.w,

                                vertical: context.isDesktop ? 26.w : 20.w,
                              ),
                              child: Text(
                                "Club Chat:",
                                style: regular(
                                  fontSize: twentyResponsive,
                                  fontFamily: AppFontFamily.secondary,
                                ),
                              ),
                            ),
                            4.h.verticalSpace,
                            horizontalDivider(),

                            //todo chat tabs
                            chatTabs(
                              title: "‘Top Punters’",
                              fourteenResponsive: fourteenResponsive,
                              color: (provider.selectedPunterWeb == 0)
                                  ? AppColors.primary
                                  : null,
                              onTap: () {
                                provider.setPunterIndex = 0;
                              },
                              context: context,
                            ),
                            horizontalDivider(),
                            chatTabs(
                              title: "‘PuntGPT Legends’",
                              fourteenResponsive: fourteenResponsive,

                              color: (provider.selectedPunterWeb == 1)
                                  ? AppColors.primary
                                  : null,

                              onTap: () {
                                provider.setPunterIndex = 1;
                              },
                              context: context,
                            ),
                            horizontalDivider(),
                            chatTabs(
                              title: "‘Mug Punters Crew’",
                              fourteenResponsive: fourteenResponsive,

                              color: (provider.selectedPunterWeb == 2)
                                  ? AppColors.primary
                                  : null,

                              onTap: () {
                                provider.setPunterIndex = 2;
                              },
                              context: context,
                            ),
                            horizontalDivider(),
                            Spacer(),
                            AppOutlinedButton(
                              margin: EdgeInsets.all(24.w),
                              textStyle: semiBold(fontSize: fourteenResponsive),
                              text: "Create New Club",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      verticalDivider(),
                      //todo ----------------> right panel
                      PunterClubChatSectionWeb(),
                      verticalDivider(),
                    ],
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomRight,
            child: askPuntGPTButtonWeb(context: context),
          ),
        ],
      ),
    );
  }

  Widget chatTabs({
    required String title,
    required double fourteenResponsive,
    Color? color,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return OnMouseTap(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(color: color),
        padding: EdgeInsets.symmetric(
          horizontal: context.isDesktop ? 24.w : 30.w,
          vertical: context.isDesktop ? 16.w : 22.w,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: bold(
                fontSize: fourteenResponsive,
                color: color == AppColors.primary ? AppColors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
