import 'package:animate_do/animate_do.dart';
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
import '../../../core/utils/field_validators.dart';
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
        : context.isBrowserMobile
        ? 36.sp
        : 20.sp;
    final fourteenResponsive = context.isDesktop
        ? 14.sp
        : context.isTablet
        ? 20.sp
        : context.isBrowserMobile
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
                                children: [
                                  Text(
                                    "Club Chat:",
                                    style: regular(
                                      fontSize: twentyResponsive,
                                      fontFamily: AppFontFamily.secondary,
                                    ),
                                  ),
                                  Spacer(),
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
                                        body: _notificationSheet(
                                          context: context,
                                          provider: provider,
                                        ),
                                      );
                                    },
                                    child: ImageWidget(
                                      path: AppAssets.webNotification,
                                      type: ImageType.svg,
                                    ),
                                  ),
                                  OnMouseTap(
                                    onTap: () => _createClubDialogue(
                                      context: context,
                                      provider: provider,
                                    ),
                                    child: Container(
                                      color: AppColors.primary,
                                      height: 21,
                                      width: 23,
                                      margin: EdgeInsets.only(left: 12.w),
                                      child: ImageWidget(
                                        path: AppAssets.addIcon,
                                        type: ImageType.svg,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            4.h.verticalSpace,
                            horizontalDivider(),

                            //todo chat tabs
                            _chatTabs(
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
                            _chatTabs(
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
                            _chatTabs(
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

  Widget _chatTabs({
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

  //todo create club dialogue
  void _createClubDialogue({
    required BuildContext context,
    required PunterClubProvider provider,
  }) {
    showDialog(
      context: context,
      builder: (dialogueCtx) {
        return ZoomIn(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //todo top bar of popup
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 18.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              "Create Punter Club",
                              style: regular(
                                fontSize: context.isDesktop ? 22.sp : 30.sp,
                                fontFamily: AppFontFamily.secondary,
                              ),
                            ),
                          ),
                          OnMouseTap(
                            onTap: () {
                              context.pop();
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: AppColors.primary,
                              size: context.isDesktop ? 22.w : 30.w,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                horizontalDivider(),
                //todo Club Name Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 24.w,
                  children: [
                    Row(children: []),
                    SizedBox(
                      width: 344.w,
                      child: AppTextField(
                        controller: provider.clubNameCtr,
                        hintText: "Search by username",
                      ),
                    ),
                    AppFilledButton(
                      width: 344.w,
                      text: "Invite User",
                      onTap: () {
                        // if (provider.clubNameCtr.text.isEmpty) {
                        //
                        // }
                        dialogueCtx.pop();
                        _inviteUserDialogue(
                          context: context,
                          provider: provider,
                        );
                      },
                      margin: EdgeInsets.only(bottom: 30.w),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //todo invite user dialogue
  void _inviteUserDialogue({
    required BuildContext context,
    required PunterClubProvider provider,
  }) {
    showDialog(
      context: context,
      builder: (dialogueCtx) {
        return ZoomIn(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //todo top bar of popup
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 22.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              "Invite Users",
                              style: regular(
                                fontSize: context.isDesktop ? 22.sp : 30.sp,
                                fontFamily: AppFontFamily.secondary,
                              ),
                            ),
                          ),
                          OnMouseTap(
                            onTap: () {
                              context.pop();
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: AppColors.primary,
                              size: context.isDesktop ? 22.w : 30.w,
                            ),
                          ),
                        ],
                      ),
                      // Text(
                      //   "Your username will be displayed to your club members.",
                      //   style: semiBold(
                      //     fontSize: 12.sp,
                      //     color: AppColors.primary.withValues(alpha: 0.6),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                horizontalDivider(),
                //todo Search User field
                24.w.verticalSpace,
                Row(children: []),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 344.w,
                        child: AppTextField(
                          controller: provider.clubNameCtr,
                          hintText: "Enter Club Name",
                          trailingIcon: AppAssets.searchIcon,
                          validator: (value) =>
                              FieldValidators().required(value, "Club Name"),
                        ),
                      ),
                      24.w.verticalSpace,
                      _userBox(),
                      _userBox(),

                      AppOutlinedButton(
                        width: 344.w,
                        text: "Invite User",
                        onTap: () {
                          // if (provider.clubNameCtr.text.isEmpty) {
                          //
                          // }
                          dialogueCtx.pop();
                          _inviteUserDialogue(
                            provider: provider,
                            context: context,
                          );
                        },
                        margin: EdgeInsets.only(bottom: 30.w, top: 40.w),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //todo user name box
  Widget _userBox() {
    return Container(
      height: 48.w,
      margin: EdgeInsets.only(bottom: 8.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            height: 48.w,
            width: 48.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: AppColors.greyColor2),
            child: ImageWidget(type: ImageType.svg, path: AppAssets.userIcon),
          ),
          15.w.horizontalSpace,
          Text("@otherpropunter_1", style: semiBold(fontSize: 16.spMin)),
          Spacer(),
          Container(
            height: 48.w,
            width: 48.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(color: AppColors.primary),
            child: ImageWidget(path: AppAssets.addUser, type: ImageType.svg),
          ),
        ],
      ),
    );
  }

  //todo notification side sheet
  Widget _notificationSheet({
    required BuildContext context,
    required PunterClubProvider provider,
  }) {
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
            _notificationBox(context: context, provider: provider),
            _notificationBox(context: context, provider: provider),
            Spacer(),
            AppOutlinedButton(
              margin: EdgeInsets.only(bottom: 30.w),
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

  //todo notification details box
  Widget _notificationBox({
    required BuildContext context,
    required PunterClubProvider provider,
  }) {
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
          10.horizontalSpace,
          Expanded(
            child: RichText(
              maxLines: 4,
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
                    text: " PuntGPT Legends",
                    style: bold(
                      fontSize: 16.sp,
                      fontFamily: AppFontFamily.primary,
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          26.responsiveSize().horizontalSpace,
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
                  _enterUserNameDialogue(context: context, provider: provider);
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
              12.w.horizontalSpace,
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

  //todo enter user name dialogue
  void _enterUserNameDialogue({
    required BuildContext context,
    required PunterClubProvider provider,
  }) {
    showDialog(
      context: context,
      builder: (dialogueCtx) {
        return ZoomIn(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //todo top bar of popup
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 18.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Create Username",
                                style: regular(
                                  fontSize: context.isDesktop ? 22.sp : 30.sp,
                                  fontFamily: AppFontFamily.secondary,
                                ),
                              ),
                              Text(
                                "Your username will be displayed to your club members.",
                                style: semiBold(
                                  fontSize: 12.sp,
                                  color: AppColors.primary.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          OnMouseTap(
                            onTap: () {
                              context.pop();
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: AppColors.primary,
                              size: context.isDesktop ? 22.w : 30.w,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                horizontalDivider(),
                //todo Club Name Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 24.w,
                  children: [
                    Row(children: []),
                    SizedBox(
                      width: 344.w,
                      child: AppTextField(
                        controller: provider.clubNameCtr,
                        hintText: "Enter Username",
                      ),
                    ),
                    AppFilledButton(
                      width: 344.w,
                      text: "Create",
                      onTap: () {
                        // if (provider.clubNameCtr.text.isEmpty) {
                        //
                        // }
                        dialogueCtx.pop();
                        _inviteUserDialogue(
                          context: context,
                          provider: provider,
                        );
                      },
                      margin: EdgeInsets.only(bottom: 30.w),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
