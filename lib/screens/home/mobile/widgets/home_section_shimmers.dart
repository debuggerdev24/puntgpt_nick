import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:shimmer/shimmer.dart';

Widget searchedItemShimmer({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: (context.isBrowserMobile) ? 35.w : 25.w,
      vertical: (context.isBrowserMobile) ? 24.w : 14.h,
    ),
    child: Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title shimmer
              Container(
                width: (context.isBrowserMobile) ? 200.w : 100.w,
                height: (context.isBrowserMobile) ? 40.h : 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 6.5.h),
              // Date shimmer
              Container(
                width: (context.isBrowserMobile) ? 150.w : 80.w,
                height: (context.isBrowserMobile) ? 30.h : 12.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 6.5.h),
              // Description shimmer
              Container(
                width: (context.isBrowserMobile) ? 350.w : 180.w,
                height: (context.isBrowserMobile) ? 40.h : 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          // Arrow icon shimmer
          Container(
            width: (context.isBrowserMobile) ? 40.w : 14.w,
            height: (context.isBrowserMobile) ? 40.w : 14.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Shimmer for the Search Detail screen (manage_saved_search)
Widget searchDetailShimmer({required BuildContext context}) {
  return Column(
    children: [
      // Top bar shimmer (back arrow + title + subtitle)
      Padding(
        padding: EdgeInsets.fromLTRB(5.w, 14.h, 25.w, 14.h),
        child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.shimmerHighlightColor,
          child: Row(
            children: [
              24.w.horizontalSpace,
              // Back icon placeholder
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title placeholder
                  Container(
                    width: (context.isBrowserMobile) ? 180.w : 120.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Subtitle placeholder
                  Container(
                    width: (context.isBrowserMobile) ? 220.w : 160.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Divider placeholder
      Container(
        height: 1,
        color: AppColors.shimmerBaseColor,
      ),
      // Body shimmer (track section + buttons)
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              // Track section shimmer (title + rows)
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    // "Track" title shimmer
                    Container(
                      width: 80.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Track rows shimmer
                    ...List.generate(3, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Label placeholder
                            Container(
                              width: 160.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            // Checkbox placeholder
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const Spacer(),
              // Edit button shimmer
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8.h),
                  height: 48.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // Delete button shimmer
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  height: 48.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    ],
  );
}




