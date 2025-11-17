import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';

import '../../../core/constants/app_colors.dart';

class SavedSearchScreen extends StatelessWidget {
  const SavedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBar(context),
        appDivider(),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return appDivider();
            },
            itemCount: 2,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SearchedItem(),
                  if (index == 1)
                    Padding(
                      padding: EdgeInsets.only(bottom: 14.h),
                      child: appDivider(),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget topBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 16.h, 23.w, 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Saved Searches",
            style: TextStyle(fontFamily: AppFontFamily.secondary, fontSize: 24),
          ),
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}

class SearchedItem extends StatelessWidget {
  const SearchedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 14.h, 25.w, 14.h),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(AppRoutes.searchDetails.name);
        },
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
