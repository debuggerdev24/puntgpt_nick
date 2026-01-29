import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/provider/punt_club/punter_club_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/punt_gpt_club/web/widgets/club_chat_screen_web.dart';

import '../../../core/constants/text_style.dart';
import '../../../core/router/web/web_routes.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/app_filed_button.dart';
import '../../../core/widgets/app_text_field.dart';
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Club Chat:",
                                    style: regular(
                                      fontSize: twentyResponsive,
                                      fontFamily: AppFontFamily.secondary,
                                    ),
                                  ),
                                  OnMouseTap(
                                    onTap: () {
                                      if (context.isMobileView) {
                                        context.pushNamed(
                                          WebRoutes.askPuntGptScreen.name,
                                        );
                                        return;
                                      }
                                      isSheetOpen = true;
                                      showModalSideSheet(
                                        context: context,
                                        useRootNavigator: false,
                                        width: 530.w,
                                        // context.isDesktop
                                        //     ? 530.w
                                        //     : 600.w,
                                        withCloseControll: true,

                                        body: _notificationSheet(context),
                                      );
                                    },
                                    child: ImageWidget(
                                      path: AppAssets.webNotification,
                                      type: ImageType.svg,
                                    ),
                                  ),
                                ],
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

Widget _notificationSheet(BuildContext context) {
  return ColoredBox(
    color: AppColors.white,
    child: Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notification(2)",
            style: regular(
              fontSize: context.isDesktop ? 20.sp : 30.sp,
              fontFamily: AppFontFamily.secondary,
              height: 1.35,
            ),
          ),
          24.w.verticalSpace,
          horizontalDivider(),
          24.w.verticalSpace,
          horizontalDivider(),
          _notificationBox(context: context),
          _notificationBox(context: context),
          AppOutlinedButton(
            borderColor: AppColors.redButton,
            textStyle: semiBold(
              fontSize: 14.responsiveTextSize(),
              color: AppColors.redButton,
            ),
            text: "Clear all",
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

Widget _notificationBox({required BuildContext context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.w),
    margin: EdgeInsets.only(bottom: 8.h),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ImageWidget(type: ImageType.svg, path: AppAssets.groupIcon),
        ),
        SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "You’ve been invited to join Punter Club",
                  style: medium(
                    fontSize: 16.sp,
                    fontFamily: AppFontFamily.primary,
                  ),
                ),

                TextSpan(
                  text: "PuntGPT Legends",
                  style: semiBold(
                    fontSize: 16.sp,
                    fontFamily: AppFontFamily.primary,
                  ),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppFilledButton(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
              isExpand: false,
              text: "Join",
              textStyle: semiBold(fontSize: 14.sp, color: AppColors.white),
              onTap: () {
                context.pop();
                showModalBottomSheet(
                  backgroundColor: AppColors.white,
                  showDragHandle: true,
                  useRootNavigator: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 370.h,
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        children: [
                          Text(
                            "Create Username",
                            style: regular(
                              fontSize: 24.sp,
                              fontFamily: AppFontFamily.secondary,
                            ),
                          ),
                          10.h.verticalSpace,
                          Text(
                            "Your username will be displayed to your club members.",
                            style: semiBold(
                              fontSize: 14.sp,
                              color: AppColors.primary.withValues(alpha: 0.6),
                            ),
                          ),
                          22.w.verticalSpace,
                          horizontalDivider(),
                          24.w.verticalSpace,
                          AppTextField(
                            controller: TextEditingController(),
                            hintText: "Enter username",
                          ),
                          AppFilledButton(
                            margin: EdgeInsets.only(top: 24.w),
                            text: "Save",
                            onTap: () {},
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            AppOutlinedButton(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              isExpand: false,
              textStyle: semiBold(fontSize: 14.sp, color: AppColors.black),

              text: "Decline",
              onTap: () {},
              margin: EdgeInsets.only(left: 10.w),
            ),

            Icon(Icons.close_rounded, size: 16),
          ],
        ),
        // Expanded(
        //   child: Column(
        //     spacing: 10,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //
        //     ],
        //   ),
        // ),
      ],
    ),
  );
}
