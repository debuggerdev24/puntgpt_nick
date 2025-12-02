import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/screens/home/mobile/widgets/filters_list.dart';
import 'package:puntgpt_nick/screens/home/mobile/widgets/home_screen_tab.dart';
import 'package:puntgpt_nick/screens/home/mobile/widgets/race_table.dart';
import 'package:puntgpt_nick/screens/home/web/widgets/home_screen_tab_web.dart';
import 'package:puntgpt_nick/screens/home/web/widgets/race_start_timing_option_web.dart';
import 'package:puntgpt_nick/screens/home/web/widgets/race_table_web.dart';
import 'package:puntgpt_nick/screens/home/web/widgets/runners_list_web.dart';
import 'package:puntgpt_nick/screens/home/web/widgets/search_section_web.dart';

import '../../../core/router/app/app_routes.dart';
import '../../../core/widgets/app_filed_button.dart';
import '../../../provider/search_engine_provider.dart';
import '../../../responsive/responsive_builder.dart';
import '../mobile/home_screen.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final isVisible = bottomInset > 0.0;
    if (isVisible != _keyboardVisible) {
      setState(() => _keyboardVisible = isVisible);
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    LogHelper.info(
      "is Mobile ${Responsive.isMobile(context)} ${context.screenWidth}",
    );
    LogHelper.info(
      "is Desktop ${Responsive.isDesktop(context)} ${context.screenWidth}",
    );
    LogHelper.info(
      "is Tablet ${Responsive.isTablet(context)} ${context.screenWidth}",
    );
    return PopScope(
      canPop: context.watch<SearchEngineProvider>().isSearched ? false : true,
      onPopInvokedWithResult: (didPop, result) {
        if (context.read<SearchEngineProvider>().isSearched) {
          context.read<SearchEngineProvider>().setIsSearched(value: false);
        }
      },
      child: Scaffold(
        body: Consumer<SearchEngineProvider>(
          builder:
              (
                BuildContext context,
                SearchEngineProvider provider,
                Widget? child,
              ) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (kIsWeb && !context.isMobile) ...[
                      70.h.verticalSpace,
                      HomeScreenTabWeb(selectedIndex: provider.selectedTab),
                    ] else ...[
                      20.h.verticalSpace,
                      HomeScreenTab(selectedIndex: provider.selectedTab),
                    ],
                    16.h.verticalSpace,
                    Expanded(
                      child: (context.isMobile)
                          ? mobileView(provider: provider, formKey: formKey)
                          : webView(provider: provider, formKey: formKey),
                    ),
                  ],
                );
              },
        ),
      ),
    );
  }

  Widget mobileView({
    required SearchEngineProvider provider,
    required GlobalKey<FormState> formKey,
  }) {
    return FadeInUp(
      from: 1,
      key: ValueKey(provider.selectedTab),
      child: (provider.selectedTab == 0)
          ? Column(
              spacing: 16,
              children: [
                //todo timing buttons
                RaceStartTimingOptionsWeb(),
                Expanded(
                  child: (provider.isSearched)
                      ? RunnersListWeb(runnerList: provider.runnersList)
                      : FilterList(formKey: formKey),
                ),
                Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: (provider.isSearched)
                      ? GestureDetector(
                          onTap: () {
                            context.pushNamed(AppRoutes.searchFilter.name);
                          },
                          child: IntrinsicHeight(
                            child: Container(
                              decoration: BoxDecoration(color: AppColors.white),
                              alignment: AlignmentDirectional.bottomCenter,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageWidget(
                                    type: ImageType.svg,
                                    path: AppAssets.filter,
                                    height: 20.w.flexClamp(18, 22),
                                  ),
                                  Text(
                                    "Filter",
                                    style: medium(fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              askPuntGPTButton(context),
                              10.verticalSpace,
                              IntrinsicWidth(
                                child: AppFiledButton(
                                  text: "Search",
                                  textStyle: semiBold(
                                    color: AppColors.white,
                                    fontSize: (kIsWeb) ? 42.sp : 20.sp,
                                  ),
                                  onTap: () {
                                    // formKey.currentState!.validate();
                                    provider.setIsSearched(value: true);
                                  },
                                ),
                              ),
                              10.verticalSpace,
                            ],
                          ),
                        ),
                ),
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next to go",
                      style: bold(fontSize: (kIsWeb) ? 32.sp : 16.sp),
                    ),
                    10.h.verticalSpace,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8.w,
                        children: [
                          raceItem(context: context),
                          raceItem(context: context),
                        ],
                      ),
                    ),
                    RaceTable(),
                    Align(
                      alignment: AlignmentGeometry.bottomRight,
                      child: askPuntGPTButton(context),
                    ),
                    25.h.verticalSpace,
                  ],
                ),
              ),
            ),
    );
  }

  Widget webView({
    required SearchEngineProvider provider,
    required GlobalKey<FormState> formKey,
  }) {
    final bodyWidth = context.isMobile
        ? 1.6.sw
        : context.isTablet
        ? 1200.w
        : 1100.w;
    final sixteenResponsive = context.isDesktop
        ? 16.sp
        : context.isTablet
        ? 24.sp
        : (kIsWeb)
        ? 32.sp
        : 16.sp;
    return Stack(
      children: [
        SingleChildScrollView(
          child: FadeInUp(
            curve: Curves.easeInOut,
            from: 4,
            key: ValueKey(provider.selectedTab),
            child: (provider.selectedTab == 0)
                ? Column(
                    spacing: 16,
                    children: [
                      //todo timing buttons
                      RaceStartTimingOptionsWeb(),
                      //todo search section mobile
                      SearchSectionWeb(formKey: formKey),
                    ],
                  )
                : Center(
                    child: SizedBox(
                      width: bodyWidth,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Next to go",
                              style: bold(fontSize: sixteenResponsive),
                            ),
                            10.w.verticalSpace,

                            //todo race list
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                spacing: 8.w,
                                children: [
                                  raceItemWeb(context: context),
                                  raceItemWeb(context: context),
                                  raceItemWeb(context: context),
                                  raceItemWeb(context: context),
                                  raceItemWeb(context: context),
                                  raceItemWeb(context: context),
                                  raceItemWeb(context: context),
                                  raceItemWeb(context: context),
                                ],
                              ),
                            ),
                            //todo race table
                            RaceTableWeb(tableWidth: bodyWidth),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        //todo ask punt gpt button web
        Align(
          alignment: Alignment.bottomRight,
          child: askPuntGPTButtonWeb(context: context),
        ),
      ],
    );
  }

  Widget raceItem({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 14.w, 14.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Morphettville",
            style: semiBold(fontSize: (kIsWeb) ? 32.sp : 16.sp),
          ),
          6.h.verticalSpace,
          Row(
            spacing: 85.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Race 1",
                style: semiBold(
                  fontSize: (kIsWeb) ? 28.sp : 14.sp,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
              ),
              Text(
                "13:15",
                style: semiBold(
                  fontSize: (kIsWeb) ? 28.sp : 14.sp,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget raceItemWeb({required BuildContext context}) {
    final sixteenFontSize = context.isDesktop
        ? 16.sp
        : context.isTablet
        ? 24.sp
        : (kIsWeb)
        ? 32.sp
        : 16.sp;
    final fourteenFontSize = context.isDesktop
        ? 14.sp
        : context.isTablet
        ? 22.sp
        : (kIsWeb)
        ? 30.sp
        : 14.sp;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 14.w, 14.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Morphettville", style: semiBold(fontSize: sixteenFontSize)),
          6.h.verticalSpace,
          Row(
            spacing: 85.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Race 1",
                style: semiBold(
                  fontSize: fourteenFontSize,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
              ),
              Text(
                "13:15",
                style: semiBold(
                  fontSize: fourteenFontSize,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget askPuntGPTButtonWeb({required BuildContext context}) {
  return OnMouseTap(
    onTap: () {
      showModalSideSheet(
        context: context,
        width: 300,
        barrierColor: Colors.black.withValues(alpha: 0.2),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Right Side Sheet",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text("This is a simple side sheet example."),
            ],
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 80.w, right: 100.w),
      padding: EdgeInsets.symmetric(
        vertical: context.isDesktop
            ? 10.w
            : context.isTablet
            ? 11.w
            : (kIsWeb)
            ? 16.w
            : 14.w,
        horizontal: context.isDesktop
            ? 18.w
            : context.isTablet
            ? 20.w
            : (kIsWeb)
            ? 22.w
            : 16.w,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            offset: Offset(0, 6),
            blurRadius: 15,
          ),
        ],
        color: AppColors.white,
        border: Border.all(color: AppColors.primary),
      ),

      child: Row(
        spacing: 10.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            path: AppAssets.horse,
            height: context.isDesktop
                ? 34.w
                : context.isTablet
                ? 28.w
                : (kIsWeb)
                ? 40.w
                : 30.w,
          ),
          Text(
            "Ask @ PuntGPT",
            textAlign: TextAlign.center,
            style: regular(
              fontSize: context.isDesktop
                  ? 18.sp
                  : context.isTablet
                  ? 25.sp
                  : (kIsWeb)
                  ? 35.sp
                  : 20.sp,
              fontFamily: AppFontFamily.secondary,
            ),
          ),
        ],
      ),
    ),
  );
}
