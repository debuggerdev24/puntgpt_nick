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
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/home/web/widgets/runners_list_web.dart';
import '../../../../core/widgets/app_filed_button.dart';
import '../../../../core/widgets/app_outlined_button.dart';

class SearchSectionWeb extends StatefulWidget {
  const SearchSectionWeb({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<SearchSectionWeb> createState() => _SearchSectionWebState();
}

class _SearchSectionWebState extends State<SearchSectionWeb> {
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
    return Consumer<SearchEngineProvider>(
      builder: (context, provider, child) => SizedBox(
        width: Responsive.isMobile(context)
            ? double.maxFinite
            : context.isTablet
        ? 1200.w
            :
        1100.w ,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "Search for a horse that meets your criteria:",
                  style: bold(fontSize:context.isDesktop ? 16.sp : context.isTablet ? 24.sp : (kIsWeb) ? 40.sp :16.sp, height: 1.2),
                ),
                OnButtonTap(
                  onTap: onSaveSearchTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageWidget(
                        type: ImageType.svg,
                        path: AppAssets.bookmark,
                        height: context.isDesktop ? 16.sp : context.isTablet ? 24.sp : (kIsWeb) ? 30.sp :16.sp,
                      ),
                      5.w.horizontalSpace,
                      Text(
                        "Saved Searches",
                        style: bold(
                          fontSize: context.isDesktop ? 16.sp : context.isTablet ? 24.sp : (kIsWeb) ? 30.sp :16.sp,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            20.h.verticalSpace,

            //todo filter view
            _buildSearchView(),
          ],
        ),
      ),
    );
  }

  /// For Mobile
  Widget _buildSearchView() {
    final provider = context.watch<SearchEngineProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //todo left panel
            SizedBox(
              width: 340.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: AppColors.transparent,
                    ),
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(
                        left: 25.w,
                        right: 25.w,
                        bottom: 8.h,
                      ),
                      tilePadding: EdgeInsets.symmetric(horizontal: 25.w),
                      iconColor: AppColors.greyColor,
                      title: Text("Track", style: semiBold(fontSize: context.isDesktop ? 14.sp : context.isTablet ? 22.sp : (kIsWeb) ? 26.sp : 14.sp,)),
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
                                    Text(item["label"], style: semiBold(fontSize: context.isDesktop ? 14.sp : context.isTablet ? 22.sp : (kIsWeb) ? 26.sp : 14.sp,)),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                      width: 22.sp,
                                      height: 22.sp,
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
                                        size: 16.sp,
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
                  appDivider(endIndent: 22),
                  90.h.verticalSpace,
                  if(provider.isSearched)
                  Text("Total Runners: (20)",style: semiBold(fontSize: context.isDesktop ? 14.sp : context.isTablet ? 22.sp : (kIsWeb) ? 26.sp : 14.sp,color: AppColors.primary.withValues(alpha: 0.6),),),
                  AppFiledButton(
                    margin: EdgeInsets.only(right: 12.w,top: provider.isSearched ? 12.h : 0),
                    text: "Search",
                    padding: (!context.isMobile) ? EdgeInsets.symmetric(vertical: (context.isDesktop) ? 12.w : 11.w,) : null,

                    textStyle: semiBold(
                      color: AppColors.white,
                      fontSize: context.isDesktop ? 14.sp : context.isTablet ? 22.sp : (kIsWeb) ? 26.sp : 14.sp,

                    ),
                    onTap: () {
                      // formKey.currentState!.validate();
                      provider.setIsSearched(
                        value:!provider.isSearched,
                      );
                    },
                  ),

                  AppOutlinedButton(
                    margin: EdgeInsets.only(top: 8.h,bottom: 70.h,right: 12.w),
                    text: "Save this Search",
                    padding: (!context.isMobile) ? EdgeInsets.symmetric(vertical: 12.w) : null,// (context.isDesktop) ? 12.w : 11.w,
                    textStyle: semiBold(
                      fontSize: context.isDesktop ? 14.sp : context.isTablet ? 22.sp : (kIsWeb) ? 26.sp : 14.sp,
                    ),

                    onTap: () {
                      // formKey.currentState!.validate();
                      provider.setIsSearched(
                        value: true,
                      );

                    },
                  ),
                ],
              ),
            ),
            //todo right panel (Grid view)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.h.verticalSpace,
                  Text("Total Runners: (20)",style: semiBold(fontSize: context.isDesktop ? 14.sp : context.isTablet ? 22.sp : (kIsWeb) ? 26.sp : 14.sp,color: AppColors.primary.withValues(alpha: 0.6),),),
                  20.h.verticalSpace,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: context.isDesktop ? 1.55.w : 2.w,
                        crossAxisSpacing: 16.w,mainAxisSpacing: 16.h), itemBuilder:(context, index) {
                    return Runner(runner: provider.runnersList[0]);
                  },
                  itemCount: 10,)
                ],
              ),
            )
          ],
        ),

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
