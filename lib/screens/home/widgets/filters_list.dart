import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
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
    final filters = context.read<SearchEngineProvider>().puntGptFilters;

    for (var filter in filters) {
      if (filter["type"] == "number") {
        _controllers[filter["label"]] = TextEditingController();
      } else if (filter["type"] == "dropdown") {
        _dropdownValues[filter["label"]] = null;
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void onSaveSearchTap() {}

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchEngineProvider>();
    final filters = provider.puntGptFilters;

    return SizedBox(
      width: Responsive.isMobile(context)
          ? double.maxFinite
          : 800.w.flexClamp(500, 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Search for a horse that meets your criteria:",
            style: bold(fontSize: 16.sp.flexClamp(14, 18), height: 1.2),
          ),
          SizedBox(height: 5),
          Text(
            "Applying too strict a criteria or too many filters may retrieve no results",
            style: medium(
              height: 1.2,
              fontSize: 14.sp.flexClamp(12, 16),
              color: AppColors.primary.setOpacity(0.8),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search Result: (20)",
                style: bold(fontSize: 16.sp.flexClamp(14, 16)),
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
                        fontSize: 16.sp.clamp(14, 18),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          /// FORM AREA
          Form(
            key: _formKey,
            child: Responsive.isMobile(context)
                ? _buildListView(filters)
                : _buildGridView(filters),
          ),
        ],
      ),
    );
  }

  /// For Mobile
  Widget _buildListView(List filters) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: filters.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final filter = filters[index];
        return _buildFilterField(filter);
      },
    );
  }

  /// For Web / Tablet
  Widget _buildGridView(List filters) {
    return MasonryGridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 5,

      itemCount: filters.length,
      itemBuilder: (context, index) {
        final filter = filters[index];
        return _buildFilterField(filter);
      },
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
