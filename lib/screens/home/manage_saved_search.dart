import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';

import '../../provider/search_engine_provider.dart';

class SearchDetailScreen extends StatelessWidget {
  const SearchDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBar(context),
        appDivider(),
        _buildListView(context: context),
        Spacer(),
        AppFiledButton(
          textStyle: semiBold(fontSize: 16, color: AppColors.white),
          text: "Edit",
          onTap: () {},
          margin: EdgeInsets.fromLTRB(25.w, 0, 25.w, 6.h),
        ),
        AppOutlinedButton(
          textStyle: semiBold(fontSize: 16, color: AppColors.black),
          text: "Delete",
          onTap: () {},
          margin: EdgeInsets.fromLTRB(25.w, 0, 25.w, 16.h),
        ),
      ],
    );
  }

  Widget topBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 7.h),
      child: Row(
        spacing: 16.w,
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.arrow_back_ios_rounded, size: 14.h),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search 1",
                style: regular(
                  fontFamily: AppFontFamily.secondary,
                  height: 1.1,
                ),
              ),
              Text(
                "Manage your saved search",
                style: medium(
                  fontSize: 14,
                  color: AppColors.greyColor.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListView({required BuildContext context}) {
    final provider = context.watch<SearchEngineProvider>();

    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
          child: ExpansionTile(
            childrenPadding: EdgeInsets.only(
              left: 25.w,
              right: 25.w,
              bottom: 8.h,
            ),
            tilePadding: EdgeInsets.symmetric(horizontal: 25.w),
            iconColor: AppColors.greyColor,
            title: Text("Track", style: semiBold(fontSize: 16)),
            children: provider.trackItems.map((item) {
              bool isChecked = item["checked"];
              return InkWell(
                onTap: () {
                  provider.toggleTrackItem(item["label"], !isChecked);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  children: [
                    Divider(color: AppColors.greyColor.withValues(alpha: 0.2)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item["label"], style: semiBold(fontSize: 16)),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isChecked
                                    ? Colors.green
                                    : AppColors.primary.withValues(alpha: 0.15),
                              ),
                              borderRadius: BorderRadius.circular(1),
                              color: isChecked
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                            child: isChecked
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        appDivider(),
      ],
    );
  }
}
