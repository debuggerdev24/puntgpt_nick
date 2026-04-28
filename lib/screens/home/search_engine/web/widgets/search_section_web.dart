import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/provider/home/search_engine/search_engine_provider.dart';
import 'package:puntgpt_nick/screens/home/search_engine/mobile/widgets/barrier_range_slider_field.dart';
import 'package:puntgpt_nick/screens/home/search_engine/mobile/widgets/jockey_horse_wins_slider_field.dart';
import 'package:puntgpt_nick/screens/home/search_engine/mobile/widgets/odds_range_slider_field.dart';
import 'package:puntgpt_nick/screens/home/search_engine/mobile/widgets/search_checkbox_field.dart';

bool isSearchDialogOpen = false;

class SearchSectionWeb extends StatefulWidget {
  const SearchSectionWeb({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<SearchSectionWeb> createState() => _SearchSectionWebState();
}

class _SearchSectionWebState extends State<SearchSectionWeb> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void onSaveSearchTap() {
    isSearchDialogOpen = true;
    showDialog(
      context: context,
      builder: (context) {
        return searchDialog(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchEngineProvider>(
      builder: (context, provider, child) => SizedBox(
        // width:
        // Responsive.isMobileWeb(context)
        //     ? double.maxFinite
        //     : context.isTablet
        //     ? 1200.w
        //     : 1100.w,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? 121 : 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!context.isDesktop) ...[
                    OnMouseTap(
                      onTap: () => _openFilterSideSheet(provider),
                      child: Icon(Icons.tune_outlined, size: 20),
                    ),
                    SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Text(
                      "Filter through form your way",
                      style: bold(
                        fontSize: 14,
                        // context.isDesktop
                        //     ? 16.sp
                        //     : context.isTablet
                        //     ? 24.sp
                        //     : (context.isMobileWeb)
                        //     ? 40.sp
                        //     : 16.sp,
                        height: 1,
                      ),
                    ),
                  ),
                  OnMouseTap(
                    onTap: onSaveSearchTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageWidget(
                          type: ImageType.svg,
                          path: AppAssets.bookmark,
                          height: 14,
                          // context.isDesktop
                          //     ? 16.sp
                          //     : context.isTablet
                          //     ? 24.sp
                          //     : (kIsWeb)
                          //     ? 30.sp
                          //     : 16.sp,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Saved Searches",
                          style: bold(
                            fontSize: 14,
                            // context.isDesktop
                            //     ? 16.sp
                            //     : context.isTablet
                            //     ? 24.sp
                            //     : (kIsWeb)
                            //     ? 30.sp
                            //     : 16.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              //* filter view
              _buildSearchView(),
            ],
          ),
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
        horizontalDivider(),
        Row(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (context.isDesktop)
              //* --------------------> left panel
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: AppMultiSelectTrackDropdown(
                        items: provider.trackList ?? const [],
                        hintText: "All Tracks",
                      ),
                    ),
                    SizedBox(height: 12),
                    horizontalDivider(),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SearchCheckboxField(
                        title: "Placed last start",
                        isChecked: provider.placedLastStart,
                        onTap: () => provider.togglePlacedLastStart(
                          !provider.placedLastStart,
                        ),
                        verticalPadding: 12,
                      ),
                    ),
                    horizontalDivider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SearchCheckboxField(
                        title: "Placed at distance",
                        isChecked: provider.placedAtDistance,
                        onTap: () => provider.togglePlacedAtDistance(
                          !provider.placedAtDistance,
                        ),
                        verticalPadding: 12,
                      ),
                    ),

                    horizontalDivider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SearchCheckboxField(
                        title: "Placed at track",
                        isChecked: provider.placeAtTrack == true,
                        onTap: () {
                          final current = provider.placeAtTrack;
                          provider.setSelectedPlaceAtTrack = current == null
                              ? true
                              : !current;
                        },
                        verticalPadding: 12,
                      ),
                    ),
                    horizontalDivider(),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: SearchCheckboxField(
                            title: "Won at track",
                            isChecked: provider.selectedWinsAtTrack == true,
                            onTap: () {
                              final current = provider.selectedWinsAtTrack;
                              provider.setSelectedWinsAtTrack = current == null
                                  ? true
                                  : !current;
                            },
                            verticalPadding: 12,
                          ),
                        ),
                        horizontalDivider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: SearchCheckboxField(
                            title: "Won at distance",
                            isChecked: provider.wonAtDistance,
                            onTap: () => provider.toggleWonAtDistance(
                              !provider.wonAtDistance,
                            ),
                            verticalPadding: 12,
                          ),
                        ),
                        horizontalDivider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: SearchCheckboxField(
                            title: "Won last start",
                            isChecked: provider.wonLastStart,
                            onTap: () => provider.toggleWonLastStart(
                              !provider.wonLastStart,
                            ),
                            verticalPadding: 12,
                          ),
                        ),
                        horizontalDivider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: SearchCheckboxField(
                            title: "Won last 12 months",
                            isChecked: provider.wonLast12Months,
                            onTap: () => provider.toggleWonLast12Months(
                              !provider.wonLast12Months,
                            ),
                            verticalPadding: 12,
                          ),
                        ),
                        horizontalDivider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: OddsRangeSliderField(
                            values: provider.oddsRangeValues,
                            onChanged: provider.updateOddsRange,
                          ),
                        ),
                        horizontalDivider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: JockeyHorseWinsSliderField(
                            values: provider.jockeyHorseWinsRangeValues,
                            onChanged: provider.updateJockeyHorseWinsRange,
                          ),
                        ),
                        horizontalDivider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: BarrierRangeSliderField(
                            values: provider.barrierRangeIndexValues,
                            onChanged: provider.updateBarrierRange,
                          ),
                        ),
                        horizontalDivider(),
                      ],
                    ),
                    SizedBox(height: 70),
                    if (provider.isSearched)
                      Text(
                        "Total Runners: (20)",
                        style: semiBold(
                          fontSize: 13,
                          // context.isDesktop
                          //     ? 14.sp
                          //     : context.isTablet
                          //     ? 22.sp
                          //     : (kIsWeb)
                          //     ? 26.sp
                          //     : 14.sp,
                          color: AppColors.primary.withValues(alpha: 0.6),
                        ),
                      ),
                    AppFilledButton(
                      margin: EdgeInsets.only(
                        right: 12,
                        top: provider.isSearched ? 12 : 0,
                      ),
                      text: "Search",

                      textStyle: semiBold(color: AppColors.white, fontSize: 12),
                      onTap: () {
                        // formKey.currentState!.validate();
                        // provider.setIsSearched(value: !provider.isSearched);
                        provider.getUpcomingRunner(onSuccess: () {
                          
                        });
                      },
                    ),

                    AppOutlinedButton(
                      margin: EdgeInsets.only(top: 6, bottom: 50, right: 10),
                      text: "Save this Search",
                      padding: (!context.isMobileWeb)
                          ? EdgeInsets.symmetric(vertical: 12)
                          : null, // (context.isDesktop) ? 12.w : 11.w,
                      textStyle: semiBold(
                        fontSize: 12,
                        // context.isDesktop
                        //     ? 14.sp
                        //     : context.isTablet
                        //     ? 22.sp
                        //     : (kIsWeb)
                        //     ? 26.sp
                        //     : 14.sp,
                      ),

                      onTap: () {
                        // formKey.currentState!.validate();
                        provider.setIsSearched(value: true);
                      },
                    ),
                  ],
                ),
              ),
            //* --------------------> right panel (Grid view)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14),
                  if (provider.isGettingRunners)
                    SizedBox.shrink()
                  else if (provider.runnersList?.isEmpty ?? true)
                    Center(
                      child: Text(
                        "No runners found!",
                        style: semiBold(
                          fontSize: 14,
                          color: AppColors.primary.withValues(alpha: 0.6),
                        ),
                      ),
                    )
                  else
                    Text(
                      "Total Runners: (20)",
                      style: semiBold(
                        fontSize: 14,
                        color: AppColors.primary.withValues(alpha: 0.6),
                      ),
                    ),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return SizedBox.shrink(); //Runner(runner: provider.runnersList[0]);
                    },
                    itemCount: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _openFilterSideSheet(SearchEngineProvider provider) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: true,
      barrierLabel: "Filter Panel",
      barrierColor: const Color(0x80000000),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (ctx, _, __) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 340,
            height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            color: AppColors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Filters",
                        style: semiBold(
                          fontSize: 16,
                          fontFamily: AppFontFamily.secondary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                horizontalDivider(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppMultiSelectTrackDropdown(
                          items: provider.trackList ?? const [],
                          hintText: "All Tracks",
                        ),
                        horizontalDivider(),
                        SearchCheckboxField(
                          title: "Placed last start",
                          isChecked: provider.placedLastStart,
                          onTap: () => provider.togglePlacedLastStart(
                            !provider.placedLastStart,
                          ),
                          verticalPadding: 16,
                        ),
                        horizontalDivider(),
                        SearchCheckboxField(
                          title: "Placed at distance",
                          isChecked: provider.placedAtDistance,
                          onTap: () => provider.togglePlacedAtDistance(
                            !provider.placedAtDistance,
                          ),
                          verticalPadding: 16,
                        ),
                        horizontalDivider(),
                        SearchCheckboxField(
                          title: "Placed at track",
                          isChecked: provider.placeAtTrack == true,
                          onTap: () {
                            final current = provider.placeAtTrack;
                            provider.setSelectedPlaceAtTrack = current == null
                                ? true
                                : !current;
                          },
                          verticalPadding: 16,
                        ),
                        horizontalDivider(),
                        Column(
                          children: [
                            SearchCheckboxField(
                              title: "Won at track",
                              isChecked: provider.selectedWinsAtTrack == true,
                              onTap: () {
                                final current = provider.selectedWinsAtTrack;
                                provider.setSelectedWinsAtTrack =
                                    current == null ? true : !current;
                              },
                              verticalPadding: 16,
                            ),
                            horizontalDivider(),
                            SearchCheckboxField(
                              title: "Won at distance",
                              isChecked: provider.wonAtDistance,
                              onTap: () => provider.toggleWonAtDistance(
                                !provider.wonAtDistance,
                              ),
                              verticalPadding: 16,
                            ),
                            horizontalDivider(),
                            SearchCheckboxField(
                              title: "Won last start",
                              isChecked: provider.wonLastStart,
                              onTap: () => provider.toggleWonLastStart(
                                !provider.wonLastStart,
                              ),
                              verticalPadding: 16,
                            ),
                            horizontalDivider(),
                            SearchCheckboxField(
                              title: "Won last 12 months",
                              isChecked: provider.wonLast12Months,
                              onTap: () => provider.toggleWonLast12Months(
                                !provider.wonLast12Months,
                              ),
                              verticalPadding: 16,
                            ),
                            horizontalDivider(),
                            OddsRangeSliderField(
                              values: provider.oddsRangeValues,
                              onChanged: provider.updateOddsRange,
                            ),
                            horizontalDivider(),
                            JockeyHorseWinsSliderField(
                              values: provider.jockeyHorseWinsRangeValues,
                              onChanged: provider.updateJockeyHorseWinsRange,
                            ),
                            horizontalDivider(),
                            BarrierRangeSliderField(
                              values: provider.barrierRangeIndexValues,
                              onChanged: provider.updateBarrierRange,
                            ),
                            horizontalDivider(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AppFilledButton(
                  text: "Apply",
                  onTap: () {
                    provider.setIsSearched(value: true);
                    ctx.pop();
                  },
                  textStyle: semiBold(color: AppColors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  // Builds a single filter field (either text or dropdown)
  // Widget _buildFilterField(Map filter) {
  //   final label = filter["label"];
  //   final type = filter["type"];
  //
  //   if (type == "number") {
  //     return AppTextField(
  //       controller: _controllers[label]!,
  //       hintText: "Enter $label",
  //       validator: (value) {
  //         if (value == null || value.trim().isEmpty) {
  //           return "$label is required";
  //         }
  //         final number = num.tryParse(value);
  //         if (number == null) {
  //           return "Please enter a valid number";
  //         }
  //         return null;
  //       },
  //     );
  //   } else {
  //     return AppTextFieldDropdown(
  //       items: List<String>.from(filter["options"]),
  //       selectedValue: _dropdownValues[label],
  //       hintText: "Select $label",
  //       onChange: (value) {
  //         setState(() => _dropdownValues[label] = value);
  //       },
  //       validator: (value) {
  //         if (value == null || value.isEmpty) {
  //           return "Please select $label";
  //         }
  //         return null;
  //       },
  //     );
  //   }
  // }

  Widget searchDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //todo top bar of popup
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saved Searches",
                  style: regular(
                    fontSize: context.isDesktop ? 22.sp : 30.sp,
                    fontFamily: AppFontFamily.secondary,
                  ),
                ),
                OnMouseTap(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColors.primary,
                    size: context.isDesktop ? 22.w : 30.w,
                  ),
                ),
              ],
            ),
          ),
          horizontalDivider(),
          //todo search items
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 28.w, 10.w, 0),
            child: Column(
              spacing: 28.w,
              children: [
                searchItem(),
                horizontalDivider(),
                searchItem(),
                horizontalDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppOutlinedButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.w,
                        horizontal: 18.w,
                      ),
                      margin: EdgeInsets.only(bottom: 6.h, top: 4.h),
                      isExpand: false,
                      textStyle: semiBold(
                        fontSize: context.isDesktop ? 14.sp : 22.sp,
                      ),
                      text: "Remove Searches",
                      onTap: () {},
                    ),
                    AppFilledButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.w,
                        horizontal: 18.w,
                      ),

                      margin: EdgeInsets.only(left: 8.w, bottom: 4.h, top: 4.h),
                      textStyle: semiBold(
                        fontSize: context.isDesktop ? 14.sp : 22.sp,
                        color: AppColors.white,
                      ),
                      isExpand: false,
                      text: "Edit",
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchItem() {
    return GestureDetector(
      onTap: () {
        context.pop();
        if (mounted) {
          context.pushNamed(AppRoutes.searchDetails.name);
        }
      },
      child: Row(
        spacing: 500.w,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search 1",
                style: semiBold(fontSize: context.isDesktop ? 16.sp : 24.sp),
              ),
              Text(
                "Sep 30, 2025",
                style: semiBold(
                  fontSize: context.isDesktop ? 12.sp : 20.sp,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
              ),
              6.5.h.verticalSpace,
              Text(
                "Randwick • 1200m • >20%",
                style: medium(fontSize: context.isDesktop ? 14.sp : 22.sp),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.black,
            size: 14.w,
          ),
        ],
      ),
    );
  }
}
