import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field_drop_down.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/provider/search_engine_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

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
    return SizedBox(
      width: Responsive.isMobile(context)
          ? double.maxFinite
          : 800.w.flexClamp(500, 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Search for a horse that meets your criteria:",
              style: bold(fontSize: 14, height: 1.2),
            ),
          ),
          5.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Runners: (20)",
                  style: bold(fontSize: 14),
                ),
                OnButtonTap(
                  onTap: onSaveSearchTap,
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
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,

          /// FORM AREA
          _buildListView(),
        ],
      ),
    );
  }

  /// For Mobile
  Widget _buildListView() {
    final provider = context.watch<SearchEngineProvider>();

    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            dividerColor: AppColors.dividerColor.withValues(alpha: 0.2),
          ),
          child: ExpansionTile(
            childrenPadding: EdgeInsets.only(
              left: 25.w,
              right: 25.w,
              bottom: 8.h,
            ),
            tilePadding: EdgeInsets.symmetric(horizontal: 25.w),
            iconColor: AppColors.dividerColor,
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
                    Divider(
                      color: AppColors.dividerColor.withValues(alpha: 0.2),
                    ),
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
                                    : AppColors.primary.setOpacity(0.15),
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
      ],
    );
  }

  /// Builds a single filter field (either text or dropdown)
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
