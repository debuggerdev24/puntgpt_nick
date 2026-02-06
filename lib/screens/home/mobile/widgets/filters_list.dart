import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
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
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final bodyHorizontalPadding = (context.isBrowserMobile) ? 50.w : 25.w;
    final provider = context.read<SearchEngineProvider>();
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: bodyHorizontalPadding),
            child: Text(
              "Search for a horse that meets your criteria:",
              style: bold(
                fontSize: (context.isBrowserMobile) ? 36.sp : 16.sp,
                height: 1.2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              (context.isBrowserMobile) ? 50.w : 25.w,
              12.h,
              20.h,
              (context.isBrowserMobile) ? 50.w : 25.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Runners: (20)",
                  style: bold(
                    fontSize: (context.isBrowserMobile) ? 36.sp : 16.sp,
                  ),
                ),
                OnMouseTap(
                  onTap: () {
                    context.pushNamed(
                      (context.isPhysicalMobile)
                          ? AppRoutes.savedSearchedScreen.name
                          : WebRoutes.savedSearchedScreen.name,
                    );
                    //* calling the api to get all saved searches
                    provider.getAllSaveSearch();
                  },
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
                          fontSize: (context.isBrowserMobile) ? 36.sp : 16.sp,

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
              left: (context.isBrowserMobile) ? 50.w : 25.w,
              right: (context.isBrowserMobile) ? 50.w : 25.w,
              bottom: 8.h,
            ),
            tilePadding: EdgeInsets.symmetric(
              horizontal: (context.isBrowserMobile) ? 50.w : 25.w,
            ),
            iconColor: AppColors.greyColor,
            title: Text(
              "Track",
              style: semiBold(
                fontSize: (context.isBrowserMobile) ? 36.sp : 16.sp,
              ),
            ),

            children: provider.trackItems.map((item) {
              bool isChecked = item.checked;
              return InkWell(
                onTap: () {
                  provider.toggleTrackItem(item.trackType.value, !isChecked);
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
                          Text(
                            item.trackType.value,
                            style: semiBold(
                              fontSize: (context.isBrowserMobile)
                                  ? 36.sp
                                  : 16.sp,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            width: (context.isBrowserMobile) ? 40.sp : 22.sp,
                            height: (context.isBrowserMobile) ? 40.sp : 22.sp,
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
                                    size: (context.isBrowserMobile)
                                        ? 30.sp
                                        : 18.sp,
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
}
