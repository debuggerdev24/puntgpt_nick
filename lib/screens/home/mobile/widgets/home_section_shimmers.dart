
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:shimmer/shimmer.dart';


/// Shimmer for the Search Detail screen (home_screen)
Widget homeScreenShimmer({required BuildContext context}) {
  final bodyHorizontalPadding = (context.isBrowserMobile) ? 50.w : 25.w;

  return Shimmer.fromColors(
    baseColor: AppColors.shimmerBaseColor,
    highlightColor: AppColors.shimmerHighlightColor,
    child: Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // "Search for a horse..." title shimmer
            Padding(
              padding: EdgeInsets.fromLTRB(
                bodyHorizontalPadding,
                16.w,
                bodyHorizontalPadding,
                0,
              ),
              child: Container(
                width: (context.isBrowserMobile) ? 420.w : 220.w,
                height: (context.isBrowserMobile) ? 40.h : 18.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
        
            // "Total runners" row shimmer
            Padding(
              padding: EdgeInsets.fromLTRB(
                (context.isBrowserMobile) ? 50.w : 25.w,
                12.w,
                (context.isBrowserMobile) ? 50.w : 25.w,
                20.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (context.isBrowserMobile) ? 260.w : 140.w,
                    height: (context.isBrowserMobile) ? 32.h : 18.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    width: (context.isBrowserMobile) ? 260.w : 150.w,
                    height: (context.isBrowserMobile) ? 32.h : 18.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
        
            horizontalDivider(),
        
            // Filters area shimmer
            Padding(
              padding: EdgeInsets.symmetric(horizontal: bodyHorizontalPadding),
              child: Column(
                children: [
                  // Track dropdown shimmer
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.w),
                    height: (context.isBrowserMobile) ? 56.h : 46.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  horizontalDivider(),
        
                  // First checkbox row shimmer (e.g. "Placed last start")
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 19.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: (context.isBrowserMobile) ? 260.w : 160.w,
                          height: (context.isBrowserMobile) ? 32.h : 18.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          width: (context.isBrowserMobile) ? 40.sp : 22.sp,
                          height: (context.isBrowserMobile) ? 40.sp : 22.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  horizontalDivider(),
        
                  // "Placed at distance" dropdown shimmer
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.w),
                    height: (context.isBrowserMobile) ? 56.h : 46.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  horizontalDivider(),
        
                  // "Odds range" text field shimmer
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      height: (context.isBrowserMobile) ? 56.h : 46.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  horizontalDivider(),
        
                  // Additional dropdown / text-field rows shimmer
                  ...List.generate(4, (index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20.w),
                          height: (context.isBrowserMobile) ? 56.h : 46.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        horizontalDivider(),
                      ],
                    );
                  }),
        
                  // Final checkbox row shimmer (e.g. "Won last start")
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: (context.isBrowserMobile) ? 260.w : 160.w,
                          height: (context.isBrowserMobile) ? 32.h : 18.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          width: (context.isBrowserMobile) ? 40.sp : 22.sp,
                          height: (context.isBrowserMobile) ? 40.sp : 22.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  horizontalDivider(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


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




