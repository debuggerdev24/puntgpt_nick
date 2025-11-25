import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field_drop_down.dart';
import 'package:puntgpt_nick/provider/search_engine_provider.dart';
import 'package:puntgpt_nick/screens/home/mobile/home_screen.dart';
import 'package:puntgpt_nick/screens/home/mobile/widgets/home_screen_tab.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';

class SelectedRaceScreen extends StatefulWidget {
  const SelectedRaceScreen({super.key});

  @override
  State<SelectedRaceScreen> createState() => _SelectedRaceScreenState();
}

class _SelectedRaceScreenState extends State<SelectedRaceScreen> {
  String selItem = "R1";
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchEngineProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 16.h, 25.w, 0),
              child: HomeScreenTab(
                selectedIndex: provider.selectedTab,
                onTap: () {
                  context.pop();
                },
              ),
            ),
            topBar(context),
            //todo dropdown here
            // Container(
            //   child: DropdownButtonFormField<String>(
            //     initialValue: "R1",
            //     items: List.generate(
            //       10,
            //       (index) => DropdownMenuItem(
            //         value: 'R${index + 1}',
            //         child: Text('R${index + 1}'),
            //       ),
            //     ),
            //     onChanged: (value) {
            //       debugPrint('Selected race: $value');
            //     },
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: AppColors.primary.withValues(alpha: 0.15),
            //         ),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: AppColors.primary),
            //       ),
            //       // ✅ Add padding around the suffix icon
            //       suffixIcon: Padding(
            //         padding: EdgeInsets.only(right: 12.w), // margin from right
            //         child: Icon(
            //           Icons.keyboard_arrow_down_rounded,
            //           color: AppColors.primary,
            //         ),
            //       ),
            //       suffixIconConstraints: BoxConstraints(
            //         minWidth: 24.w,
            //         minHeight: 24.h,
            //       ),
            //     ),
            //     style: semiBold(fontSize: 16, color: AppColors.primary),
            //     dropdownColor: Colors.white,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),

              child: AppTextFieldDropdown(
                items: List.generate(10, (index) {
                  return "R ${index + 1}";
                }),
                selectedValue: selItem,
                onChange: (value) {
                  setState(() {
                    selItem = value;
                  });
                },
                hintText: "R1",
              ),
            ),

            SelectedRaceTable(),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 25.h, right: 25.w),
                child: askPuntGPTButton(context),
              ),
            ),
          ],
        );
      },
    );
  }

  List item = ["sjkb"];

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(6.w, 25.h, 25.w, 20.h),
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
                    "Flemington",
                    style: regular(
                      fontSize: 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "PuntGPT Legends Stakes 3200m. Date. Time",
                    style: semiBold(
                      fontSize: 14.sp,
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

class SelectedRaceTable extends StatefulWidget {
  const SelectedRaceTable({super.key});

  @override
  State<SelectedRaceTable> createState() => _SelectedRaceTableState();
}

class _SelectedRaceTableState extends State<SelectedRaceTable> {
  int? expandedIndex;

  final List<Map<String, String>> horses = [
    {"name": "Prince of Penzance"},
    {"name": "Makybe Diva"},
    {"name": "Fiorente"},
    {"name": "Gold Trip"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.only(top: 24.h, bottom: 55.h),
        width: 1.4.sw,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Table(
          border: TableBorder.symmetric(
            inside: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          columnWidths: {0: FlexColumnWidth(1.6.w), 1: FlexColumnWidth(3.w)},
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: List.generate(horses.length, (index) {
            final isExpanded = expandedIndex == index;
            return TableRow(
              decoration: BoxDecoration(),
              children: [
                IntrinsicHeight(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedIndex = isExpanded ? null : index;
                      });
                    },
                    child: Container(
                      color: isExpanded
                          ? AppColors.primary
                          : Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 16.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}. ${horses[index]["name"]!}",
                              style: semiBold(
                                fontSize: 16.sp,
                                color: isExpanded ? Colors.white : null,
                              ),
                            ),
                            if (isExpanded) ...[
                              12.h.verticalSpace,
                              Text(
                                "\$2.10",
                                style: semiBold(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              AppFiledButton(
                                margin: EdgeInsets.only(top: 4),
                                text: "Add to Tip Slip",
                                textStyle: semiBold(
                                  fontSize: 14.sp,
                                  color: AppColors.primary,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 9.h),
                                color: AppColors.white,
                                onTap: () {},
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  child: isExpanded
                      ? Align(
                          alignment: AlignmentGeometry.topLeft,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            runSpacing: 14.h,
                            spacing: 12.w,
                            children: [
                              ...[
                                "Weight",
                                "Jockey",
                                "Form",
                                "Trainer",
                                "Career",
                                "Track",
                                "Distance",
                                "1st up",
                                "2nd up",
                                "3rd up",
                                "Firm",
                                "Soft",
                                "Heavy",
                              ].map(
                                (label) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      label,
                                      style: medium(
                                        fontSize: 14.sp,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    VerticalDivider(color: AppColors.primary),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          "W: J: F: T:",
                          style: medium(fontSize: 14.sp, color: AppColors.primary),
                        ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDetailBox(String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: semiBold(fontSize: 13.sp, color: AppColors.primary),
      ),
    );
  }
}
