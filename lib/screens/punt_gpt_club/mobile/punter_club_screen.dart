import 'package:badges/badges.dart' as badge;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/provider/punt_club/punter_club_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/home/mobile/home_screen.dart';

import '../../../core/widgets/app_filed_button.dart';
import '../../../core/widgets/app_text_field.dart';

class PunterClubScreen extends StatelessWidget {
  const PunterClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PunterClubProvider>(
      builder: (sheetContext2, provider, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (sheetContext2.isBrowserMobile) ? 35.w : 25.w,
                vertical: 22.h,
              ),
              child: Row(
                children: [
                  ImageWidget(
                    path: AppAssets.groupIcon,
                    type: ImageType.svg,
                    height: (sheetContext2.isBrowserMobile) ? 42.w : null,
                  ),
                  (sheetContext2.isBrowserMobile)
                      ? 60.w.horizontalSpace
                      : 12.w.horizontalSpace,
                  Text(
                    "Your Punters Clubs:",
                    style: regular(
                      fontSize: (sheetContext2.isBrowserMobile) ? 38.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: sheetContext2,
                        useRootNavigator: true,
                        showDragHandle: true,
                        backgroundColor: AppColors.white,
                        builder: (sheetContext) {
                          return NotificationBottomSheetView();
                        },
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: badge.Badge(
                      position: badge.BadgePosition.topStart(
                        top: -10,
                        start: 20.w,
                      ),

                      badgeStyle: badge.BadgeStyle(badgeColor: AppColors.black),
                      badgeContent: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: ImageWidget(
                        path: AppAssets.notification,
                        type: ImageType.svg,
                        height: 28,
                        width: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: sheetContext2,
                        backgroundColor: AppColors.white,
                        showDragHandle: true,
                        useRootNavigator: true,
                        builder: (sheetContext) {
                          return Container(
                            height: 310.h,
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              children: [
                                Text(
                                  "Create Punter Club",
                                  style: regular(
                                    fontSize: 24.sp,
                                    fontFamily: AppFontFamily.secondary,
                                  ),
                                ),
                                16.h.verticalSpace,
                                horizontalDivider(),
                                24.h.verticalSpace,
                                AppTextField(
                                  controller: provider.clubNameCtr,
                                  hintText: "Enter Club Name",
                                ),
                                AppFilledButton(
                                  margin: EdgeInsets.only(top: 24.h),
                                  text: "Invite Users",
                                  onTap: () {
                                    sheetContext.pop();
                                    showModalBottomSheet(
                                      context: context,

                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      backgroundColor: AppColors.white,
                                      builder: (_) {
                                        return InviteUserSheetView();
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      color: AppColors.primary,
                      height: 28,
                      width: 30,
                      margin: EdgeInsets.only(left: 12.w),
                      child: ImageWidget(
                        width: 30.w,
                        path: AppAssets.addIcon,
                        type: ImageType.svg,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            horizontalDivider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: provider.clubsList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final club = provider.clubsList[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.pushNamed(
                      (context.isMobileView && kIsWeb)
                          ? WebRoutes.punterClubChatScreen.name
                          : AppRoutes.punterClubChatScreen.name,
                      extra: club,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: (index % 2 == 0) ? null : AppColors.primary,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 20.h,
                    ),

                    child: Text(
                      club,
                      style: bold(
                        fontSize: (context.isBrowserMobile) ? 32.sp : 16.sp,
                        color: (index % 2 == 0) ? null : AppColors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            horizontalDivider(),
            Spacer(),
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                child: askPuntGPTButton(sheetContext2),
              ),
            ),
          ],
        );
      },
    );
  }
}

class InviteUserSheetView extends StatelessWidget {
  const InviteUserSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PunterClubProvider>();
    return SizedBox(
      height: 0.89.sh,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  "Invite Users",
                  style: regular(
                    fontSize: 24.sp,
                    fontFamily: AppFontFamily.secondary,
                  ),
                ),
                20.h.verticalSpace,
                horizontalDivider(),
                20.h.verticalSpace,
                AppTextField(
                  controller: provider.searchNameCtr,
                  hintText: "Search by username",
                  trailingIcon: AppAssets.searchIcons,
                  //(Icons.search),
                ),
              ],
            ),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationBottomSheetView extends StatelessWidget {
  const NotificationBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          Text(
            "Notifications",
            style: regular(
              fontSize: 24.sp,
              fontFamily: AppFontFamily.secondary,
            ),
          ),
          16.h.verticalSpace,
          horizontalDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  19.h.verticalSpace,
                  notificationBox(),
                  notificationBox(),
                  notificationBox(),
                ],
              ),
            ),
          ),
          SafeArea(
            child: AppOutlinedButton(
              color: AppColors.redButton,
              margin: EdgeInsets.symmetric(vertical: 10.h),
              textStyle: semiBold(fontSize: 16.sp, color: AppColors.redButton),
              text: "Clear all",
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationBox() {
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

          SizedBox(width: 10), //
          Expanded(
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppFilledButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.w,
                        vertical: 9.h,
                      ),
                      isExpand: false,
                      text: "Join",
                      textStyle: semiBold(
                        fontSize: 14.sp,
                        color: AppColors.white,
                      ),
                      onTap: () {},
                    ),
                    AppOutlinedButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.w,
                        vertical: 8.h,
                      ),
                      isExpand: false,
                      textStyle: semiBold(
                        fontSize: 14.sp,
                        color: AppColors.black,
                      ),

                      text: "Decline",
                      onTap: () {},
                      margin: EdgeInsets.only(left: 10.w),
                    ),
                    Spacer(),
                    Icon(Icons.close_rounded, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
