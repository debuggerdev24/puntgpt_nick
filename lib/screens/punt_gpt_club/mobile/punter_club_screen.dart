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
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/provider/punt_club/punter_club_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/home/mobile/home_screen.dart';

class PunterClubScreen extends StatelessWidget {
  const PunterClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PunterClubProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (context.isBrowserMobile) ? 35.w : 25.w,
                vertical: 22.h,
              ),
              child: Row(
                children: [
                  ImageWidget(
                    path: AppAssets.groupIcon,
                    type: ImageType.svg,
                    height: (context.isBrowserMobile) ? 42.w : null,
                  ),
                  (context.isBrowserMobile) ? 60.w.horizontalSpace : 12.w.horizontalSpace,
                  Text(
                    "Your Punters Clubs:",
                    style: regular(
                      fontSize: (context.isBrowserMobile) ? 38.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                    ),
                  ),
                  Spacer(),
                  Container(
                    color: AppColors.primary,
                    height: 28,
                    width: 30,
                    child: ImageWidget(
                      width: 30.w,
                      path: AppAssets.addIcon,
                      type: ImageType.svg,
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
                child: askPuntGPTButton(context),
              ),
            ),
          ],
        );
      },
    );
  }
}
