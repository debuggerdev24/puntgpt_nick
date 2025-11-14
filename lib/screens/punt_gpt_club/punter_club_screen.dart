import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/provider/punter_club_provider.dart';
import 'package:puntgpt_nick/screens/home/home_screen.dart';

class PunterClubScreen extends StatelessWidget {
  const PunterClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PunterClubProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 22.h, 25.w, 22.h),
              child: Row(
                children: [
                  ImageWidget(path: AppAssets.groupIcon, type: ImageType.svg),
                  12.w.horizontalSpace,
                  Text(
                    "Your Punters Clubs:",
                    style: regular(
                      fontSize: 24,
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
            appDivider(),
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
                      AppRoutes.punterClubChat.name,
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
                        fontSize: 16,
                        color: (index % 2 == 0) ? null : AppColors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            appDivider(),
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
