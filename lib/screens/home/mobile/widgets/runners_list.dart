import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/models/runner_model.dart';

import '../../../../core/router/app/app_routes.dart';
import '../../../../core/widgets/image_widget.dart';

class RunnersList extends StatelessWidget {
  const RunnersList({super.key, required this.runnerList});
  final List<RunnerModel> runnerList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25.w, 0.h, 25.w, 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Runners: (20)", style: bold(fontSize: 16.sp)),
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
                      height: 16.w.flexClamp(14, 18),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Saved Searches",
                      style: bold(
                        fontSize: 16.sp,
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
          child: ListView.builder(
            itemCount: runnerList.length,
            itemBuilder: (context, index) {
              final runner = runnerList[index];
              return Container(
                margin: EdgeInsets.fromLTRB(25.w, 0, 25.w, 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.greyColor.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 3),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            width: 22,
                            height: 22,
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
                              size: 16,
                            ),
                            // isChecked
                            //     ? const Icon(Icons.check, color: Colors.white, size: 16)
                            //     : null,
                          ),
                          15.horizontalSpace,
                          Text(
                            "${runner.number.toString()}. ",
                            style: bold(fontSize: 18.sp),
                          ),
                          Text(runner.label, style: semiBold(fontSize: 18.sp)),
                          Spacer(),
                          Text("\$${runner.price}", style: bold(fontSize: 18.sp)),
                        ],
                      ),
                    ),
                    Divider(color: AppColors.greyColor.withValues(alpha: 0.15)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                      child: Text(
                        "${runner.date}. ",
                        style: medium(fontSize: 16.sp),
                      ),
                    ),
                    Divider(color: AppColors.greyColor.withValues(alpha: 0.15)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                      child: Text(
                        "${runner.numberOfRace} Races",
                        style: medium(fontSize: 16.sp),
                      ),
                    ),
                    Divider(color: AppColors.greyColor.withValues(alpha: 0.15)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                      child: Text(
                        "Next race ${runner.nextRaceRemainTime}",
                        style: medium(fontSize: 16.sp),
                      ),
                    ),
                    Divider(color: AppColors.greyColor.withValues(alpha: 0.15)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 6, 8, 16),
                      child: Row(
                        spacing: 6.w,
                        children: [
                          Expanded(
                            child: AppFiledButton(
                              text: "Add to Tip Slip",
                              textStyle: semiBold(
                                fontSize: 16.sp,
                                color: AppColors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 6.w,
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
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
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 6.w,
                                ),
                                // padding: EdgeInsets.symmetric(
                                //   vertical: 8.h,
                                //   horizontal: 6.w,
                                // ),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.primary),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ImageWidget(
                                      path: AppAssets.horse,
                                      height: 24.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Ask @ PuntGPT",
                                        textAlign: TextAlign.center,
                                        style: bold(fontSize: 16.sp),
                                      ),
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
            },
          ),
        ),
      ],
    );
  }
}
