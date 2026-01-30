import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/home/web/widgets/chat_section_web.dart';

import '../../../../core/constants/text_style.dart';
import '../../../../core/widgets/app_devider.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../provider/account/account_provider.dart';

class PunterClubChatSectionWeb extends StatelessWidget {
  const PunterClubChatSectionWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final sixteenResponsive = context.isDesktop
        ? 16.sp
        : context.isTablet
        ? 24.sp
        : (context.isBrowserMobile)
        ? 32.sp
        : 16.sp;
    final twelveResponsive = context.isDesktop
        ? 12.sp
        : context.isTablet
        ? 20.sp
        : (context.isBrowserMobile)
        ? 28.sp
        : 12.sp;
    final fourteenResponsive = context.isDesktop
        ? 14.sp
        : context.isTablet
        ? 22.sp
        : (context.isBrowserMobile)
        ? 26.sp
        : 14.sp;
    return Consumer<AccountProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.isDesktop ? 24.w : 30.w,
                  vertical: context.isDesktop ? 11.w : 17.w,
                ),
                child: topBar(
                  context: context,
                  twelveResponsive: twelveResponsive,
                  fourteenResponsive: fourteenResponsive,
                ),
              ),
              horizontalDivider(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ChatSectionWeb(),
                    ChatSectionWeb(),
                    ChatSectionWeb(),
                  ],
                ),
              ),
              horizontalDivider(),
              TextField(
                style: regular(fontSize: sixteenResponsive),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefix: SizedBox(width: 25.w),
                  hintText: "Type your message...",
                  hintStyle: medium(
                    fontStyle: FontStyle.italic,
                    fontSize: sixteenResponsive,
                    color: AppColors.greyColor.withValues(alpha: 0.6),
                  ),
                ),
              ),
              Container(
                height: 40.w,
                color: AppColors.primary,
                width: double.infinity,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget topBar({
    required BuildContext context,
    required double twelveResponsive,
    required double fourteenResponsive,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "‘PuntGPT Legends’",
              style: regular(
                fontSize: context.isDesktop ? 24.sp : 30.sp,
                fontFamily: AppFontFamily.secondary,
                height: 1.35,
              ),
            ),
            Text(
              "11 members",
              style: semiBold(
                fontSize: twelveResponsive,
                color: AppColors.greyColor.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        Spacer(),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (TapDownDetails details) {
              // Get the widget's RenderBox
              final RenderBox renderBox =
                  context.findRenderObject() as RenderBox;

              // Get widget's position relative to the screen
              final Offset offset = renderBox.localToGlobal(Offset.zero);

              // Get widget's size
              final Size size = renderBox.size;

              // Get screen size for boundary calculation
              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;

              final RelativeRect position = RelativeRect.fromRect(
                Rect.fromLTWH(
                  offset.dx +
                      (context.isDesktop
                          ? 35
                          : context.isTablet
                          ? 15
                          : context.isBrowserMobile
                          ? 10
                          : 35),
                  offset.dy - 20,
                  size.width, // Width of widget
                  0,
                ),
                Offset.zero & overlay.size, // Screen bounds
              );

              showMenu(
                context: context,
                position: position,
                color: AppColors.white,
                shadowColor: AppColors.primary,

                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    onTap: () {
                      showModalSideSheet(
                        context: context,
                        useRootNavigator: false,
                        width: 530.w,
                        // context.isDesktop
                        //     ? 530.w
                        //     : 600.w,
                        withCloseControll: true,

                        body: _inviteUserSheet(context),
                      );
                    },
                    value: "view",

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "View Members",
                          style: semiBold(fontSize: 14.responsiveTextSize()),
                        ),
                        Icon(Icons.chevron_right, size: 18),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(height: 0),

                  PopupMenuItem(
                    value: "rename",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Change Name",
                          style: semiBold(fontSize: 14.responsiveTextSize()),
                        ),
                        Icon(Icons.chevron_right, size: 18),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(height: 0),

                  PopupMenuItem(
                    value: "leave",
                    child: AppOutlinedButton(
                      isExpand: false,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.responsiveTextSize(),
                        horizontal: 20.responsiveSize(),
                      ),
                      margin: EdgeInsets.only(top: 35.w, bottom: 20.w),
                      text: "Leave Group",
                      textStyle: semiBold(
                        fontSize: 14.responsiveTextSize(),
                        color: AppColors.redButton,
                      ),
                      borderColor: AppColors.redButton,
                      onTap: () {},
                    ),
                  ),
                ],
              );
            },
            child: Row(
              children: [
                ImageWidget(
                  path: AppAssets.addClubMember,
                  type: ImageType.svg,
                  color: AppColors.primary,
                  height: context.isDesktop ? 20.w : 28.w,
                ),
                context.isDesktop ? 10.w.horizontalSpace : 20.w.horizontalSpace,
                Text(
                  "Add New Members",
                  style: semiBold(fontSize: fourteenResponsive),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _inviteUserSheet(BuildContext context) {
  return ColoredBox(
    color: AppColors.white,
    child: Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invite Users",
            style: regular(
              fontSize: context.isDesktop ? 20.sp : 30.sp,
              fontFamily: AppFontFamily.secondary,
              height: 1.35,
            ),
          ),
          21.w.verticalSpace,
          horizontalDivider(),
          21.w.verticalSpace,

          AppTextField(
            controller: TextEditingController(),
            hintText: "Search by username",
            trailingIcon: AppAssets.searchIcon,
            //(Icons.search),
          ),
          24.verticalSpace,
          _userBox(),
          10.verticalSpace,
          _userBox(),
          Spacer(),
        ],
      ),
    ),
  );
}

Widget _userBox() {
  return Container(
    height: 48.w,

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
