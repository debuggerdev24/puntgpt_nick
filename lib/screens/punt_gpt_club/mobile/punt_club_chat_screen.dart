import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
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
    if (!context.isMobile) {
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

                  child: (kIsWeb)
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
                prefix: SizedBox(width: (kIsWeb) ? 35.w : 25.w),
                hintText: "Type your message...",
                hintStyle: medium(
                  fontStyle: FontStyle.italic,
                  fontSize: (kIsWeb) ? 28.sp : 14.sp,
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
          padding: EdgeInsets.fromLTRB(5.w, 12.h, 25.w, 16.h),
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
                      fontSize: (kIsWeb) ? 36.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "11 Member",
                    style: semiBold(
                      fontSize: (kIsWeb) ? 26.sp : 14.sp,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}
