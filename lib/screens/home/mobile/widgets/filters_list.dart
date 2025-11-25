import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field_drop_down.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/provider/search_engine_provider.dart';

class FilterList extends StatefulWidget {
  const FilterList({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  late GlobalKey<FormState> _formKey;

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String?> _dropdownValues = {};

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey;
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void onSaveSearchTap() {
    context.pushNamed(AppRoutes.savedSearched.name);
  }

  @override
  Widget build(BuildContext context) {
    final bodyHorizontalPadding = (kIsWeb) ? 50.w : 25.w;
    return SizedBox(
      width:double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: bodyHorizontalPadding
            ),
            child: Text(
              "Search for a horse that meets your criteria:",
              style: bold(fontSize: (kIsWeb) ? 36.sp :16.sp, height: 1.2),
            ),


          ),
          Padding(
            padding: EdgeInsets.fromLTRB((kIsWeb) ? 50.w : 25.w, 12.h, 20.h, (kIsWeb) ? 50.w : 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Runners: (20)", style: bold(fontSize: (kIsWeb) ? 36.sp :16.sp,)),
                OnMouseTap(
                  onTap: onSaveSearchTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageWidget(
                        type: ImageType.svg,
                        path: AppAssets.bookmark,
                        height: 16.w.flexClamp(14, 18),
                      ),
                      5.w.horizontalSpace,
                      Text(
                        "Saved Searches",
                        style: bold(
                          fontSize: (kIsWeb) ? 36.sp :16.sp,

                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // FORM AREA
          _buildFilterSection(),
        ],
      ),
    );
  }

  /// For Mobile
  Widget _buildFilterSection() {
    final provider = context.watch<SearchEngineProvider>();

    return Column(
      children: [
        horizontalDivider(),
        Theme(
          data: Theme.of(context).copyWith(
            dividerColor: AppColors.transparent,
          ), //AppColors.greyColor.withValues(alpha: 0.2)
          child: ExpansionTile(
            childrenPadding: EdgeInsets.only(
              left: (kIsWeb) ? 50.w : 25.w,
              right: (kIsWeb) ? 50.w : 25.w,
              bottom: 8.h,
            ),
            tilePadding: EdgeInsets.symmetric(horizontal: (kIsWeb) ? 50.w : 25.w),
            iconColor: AppColors.greyColor,
            title: Text("Track", style: semiBold(fontSize:  (kIsWeb) ? 36.sp :16.sp)),

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
                          Text(item["label"], style: semiBold(fontSize: (kIsWeb) ? 36.sp :16.sp,)),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            width: (kIsWeb) ? 40.sp : 22.sp,
                            height: (kIsWeb) ? 40.sp : 22.sp,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isChecked
                                    ? Colors.green
                                    : AppColors.primary.setOpacity(0.15),
                              ),
                              borderRadius: BorderRadius.circular(1),
                              color: isChecked
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                            child: isChecked
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: (kIsWeb) ? 30.sp : 18.sp,
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
        horizontalDivider(),
      ],
    );
  }

  // Builds a single filter field (either text or dropdown)
  Widget _buildFilterField(Map filter) {
    final label = filter["label"];
    final type = filter["type"];

    if (type == "number") {
      return AppTextField(
        controller: _controllers[label]!,
        hintText: "Enter $label",
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label is required";
          }
          final number = num.tryParse(value);
          if (number == null) {
            return "Please enter a valid number";
          }
          return null;
        },
      );
    } else {
      return AppTextFieldDropdown(
        items: List<String>.from(filter["options"]),
        selectedValue: _dropdownValues[label],
        hintText: "Select $label",
        onChange: (value) {
          setState(() => _dropdownValues[label] = value);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please select $label";
          }
          return null;
        },
      );
    }
  }
}
