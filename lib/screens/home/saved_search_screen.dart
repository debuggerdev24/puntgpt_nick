import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';

import '../../core/constants/app_colors.dart';

class SavedSearchScreen extends StatelessWidget {
  const SavedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25.w, 18.h, 23.w, 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Saved Searches",
                style: TextStyle(
                  fontFamily: AppFontFamily.secondary,
                  fontSize: 24.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.close_rounded),
              ),
            ],
          ),
        ),
        Divider(color: AppColors.dividerColor.withValues(alpha: 0.2)),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColors.dividerColor.withValues(alpha: 0.2),
              );
            },
            itemCount: 2,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SearchedItem(),
                  if (index == 1)
                    Divider(
                      color: AppColors.dividerColor.withValues(alpha: 0.2),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchedItem extends StatelessWidget {
  const SearchedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 8.h, 25.w, 10.h),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(AppRoutes.searchDetail.name);
        },
        // behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Search 1"),
                Text(
                  "Sep 30, 2025",
                  style: semiBold(
                    fontSize: 12.sp,
                    color: AppColors.greyColor.withValues(alpha: 0.6),
                  ),
                ),
                6.5.h.verticalSpace,
                Text("Randwick • 1200m • >20%"),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.black,
              size: 14.h,
            ),
          ],
        ),
      ),
    );
  }
}
