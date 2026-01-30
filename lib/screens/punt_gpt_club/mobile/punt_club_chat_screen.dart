import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/home/mobile/home_screen.dart';
import 'package:puntgpt_nick/screens/home/web/home_screen_web.dart';

import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';
import '../../home/mobile/widgets/chat_section.dart';

class PuntClubChatScreen extends StatelessWidget {
  const PuntClubChatScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    if (!context.isMobileView) {
      context.pop();
    }
    return Column(
      children: [
        topBar(context),
        Expanded(
          child: Stack(
            children: [
              ListView(children: [ChatSection(), ChatSection()]),
              Padding(
                padding: EdgeInsets.only(bottom: 25.h, right: 25.w),
                child: Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: (context.isBrowserMobile)
                      ? askPuntGPTButtonWeb(context: context)
                      : askPuntGPTButton(context),
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            horizontalDivider(),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefix: SizedBox(
                  width: (context.isBrowserMobile) ? 35.w : 25.w,
                ),
                hintText: "Type your message...",
                hintStyle: medium(
                  fontStyle: FontStyle.italic,
                  fontSize: (context.isBrowserMobile) ? 28.sp : 14.sp,
                  color: AppColors.greyColor.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(4.w, 12.h, 25.w, 16.h),
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
                    title,
                    style: regular(
                      fontSize: (context.isBrowserMobile) ? 36.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "11 Member",
                    style: semiBold(
                      fontSize: (context.isBrowserMobile) ? 26.sp : 14.sp,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              Spacer(),

              ImageWidget(
                width: 28.w,
                path: AppAssets.addClubMember,
                type: ImageType.svg,
                color: AppColors.primary,
              ),
              20.w.horizontalSpace,
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useRootNavigator: true,
                    showDragHandle: true,
                    backgroundColor: AppColors.white,
                    builder: (context) {
                      return OptionsSheetView();
                    },
                  );
                },
                child: ImageWidget(
                  width: 28.w,
                  path: AppAssets.option,
                  type: ImageType.svg,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}

class OptionsSheetView extends StatelessWidget {
  const OptionsSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.89.sh,

      child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 25.h),
        child: Column(
          children: [
            Text(
              "Option",
              style: regular(
                fontSize: 24.sp,
                fontFamily: AppFontFamily.secondary,
              ),
            ),
            18.h.verticalSpace,
            horizontalDivider(),
            24.w.verticalSpace,
            optionItem(title: "View Members"),
            24.w.verticalSpace,
            horizontalDivider(),
            24.w.verticalSpace,

            optionItem(title: "Change Name"),
            24.w.verticalSpace,
            horizontalDivider(),
          ],
        ),
      ),
    );
  }

  Widget optionItem({required String title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 11.w,
      children: [
        Text(title, style: semiBold(fontSize: 16.sp)),

        Icon(Icons.arrow_forward_ios_rounded, size: 12),
      ],
    );
  }
}
