import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/models/runner_model.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../../../../core/router/app/app_routes.dart';
import '../../../../core/widgets/image_widget.dart';

class RunnersListWeb extends StatelessWidget {
  const RunnersListWeb({super.key, required this.runnerList});
  final List<RunnerModel> runnerList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25.w, 0.h, 25.w, (kIsWeb) ? 8.h : 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text("Total Runners: (20)", style: bold(fontSize: (kIsWeb) ? 25.sp :16.sp,)),
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.savedSearched.name);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageWidget(
                      type: ImageType.svg,
                      path: AppAssets.bookmark,
                      height: (kIsWeb) ? 25.sp :16.sp,
                    ),
                    5.horizontalSpace,
                    Text(
                      "Saved Searches",
                      style: bold(
                        fontSize: (kIsWeb) ? 25.sp :16.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal:  25.w),

            itemCount: runnerList.length,
            separatorBuilder: (context, index) => 16.h.verticalSpace,
            itemBuilder: (context, index) {
              final runner = runnerList[index];
              return Runner(runner: runner);
            },
          ),
        ),
      ],
    );
  }
}

class Runner extends StatelessWidget {
  const Runner({super.key, required this.runner});
  final RunnerModel runner;

  @override
  Widget build(BuildContext context) {
    final sixteenFontSize =  context.isDesktop ? 16.sp : context.isTablet ? 22.sp : (kIsWeb) ? 30.sp : 16.sp;
    final fourteenFontSize =   context.isDesktop ? 14.sp : context.isTablet ? 22.sp : (kIsWeb) ? 26.sp : 14.sp;
    return Container(
      margin: EdgeInsets.only(bottom: (kIsWeb) ? 0 : 16.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.h,vertical: 9.h),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: 22.sp,
                  height: 22.sp,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                      // isChecked
                      //     ? Colors.green
                      //     :
                      AppColors.primary.setOpacity(0.15),
                    ),
                    color: Colors
                        .transparent, //isChecked ? Colors.green : Colors.transparent,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  // isChecked
                  //     ? const Icon(Icons.check, color: Colors.white, size: 16)
                  //     : null,
                ),
                15.horizontalSpace,
                Text(
                  "${runner.number.toString()}. ",
                  style: bold(fontSize: sixteenFontSize),
                ),
                Text(runner.label, style: semiBold(fontSize: sixteenFontSize)),
                Spacer(),


                Text("\$${runner.price}", style: bold(fontSize: sixteenFontSize)),
              ],
            ),
          ),
          appDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 9.h),
            child: Text(
              "${runner.date}. ",
              style: medium(fontSize: fourteenFontSize),
            ),
          ),
          appDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 9.h),
            child: Text(
              "${runner.numberOfRace} Races",
              style: medium(fontSize: fourteenFontSize),
            ),
          ),

          appDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 9.h),
            child: Text(
              "Next race ${runner.nextRaceRemainTime}",
              style: medium(fontSize: fourteenFontSize),
            ),
          ),
          appDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
            child: Row(
              spacing: 6.w,
              children: [
                Expanded(
                  child: AppFiledButton(
                    text: "Add to Tip Slip",
                    textStyle: semiBold(
                      fontSize: context.isDesktop ? 14.sp : context.isTablet ? 20.sp : (kIsWeb) ? 26.sp : 14.sp,
                      color: AppColors.white,
                    ),
                    padding: (!context.isMobile) ? EdgeInsets.symmetric(vertical: (context.isDesktop) ? 12.w : 10.h,horizontal: 6.w
                    ) : null,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: OnMouseTap(
                    onTap: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(
                              22.w,
                              5.h,
                              22.w,
                              25.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.greyColor.withValues(
                                  alpha: 0.15,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    14.w,
                                    18.h,
                                    14.w,
                                    12.h,
                                  ),
                                  child: Text(
                                    "Analysis and Field Comparison",
                                    style: semiBold(fontSize: 16.sp),
                                  ),
                                ),
                                Divider(
                                  color: AppColors.greyColor
                                      .withValues(alpha: 0.2),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    22.w,
                                    10.h,
                                    22.w,
                                    16.h,
                                  ),
                                  child: Text(
                                    "‘Delicacy’ @8.50  might offer value as a top 3 contender, especially if the favourite gets caught wide or overworks early. Look for  signs like a strong final 400m that it's shown in recent form. I like your simple formula, not overthinking things. Keep in mind the favourite, ‘Makybe Diva’ is short odds @2.10 I can take you to the manual form guide for a look at the other runners in this race?",
                                    style: regular(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: (!context.isMobile) ? EdgeInsets.symmetric(vertical: (context.isDesktop) ? 9.w : 8.h,horizontal: 6.w
                      ) : EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Row(
                        spacing: 6.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageWidget(
                            path: AppAssets.horse,
                            height: 24.w,
                          ),
                          Text(
                            "Ask PuntGPT",
                            textAlign: TextAlign.center,

                            style: bold(fontSize: context.isDesktop ? 14.sp : context.isTablet ? 20.sp : (kIsWeb) ? 26.sp : 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
