import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/screens/home/widgets/filters_list.dart';
import 'package:puntgpt_nick/screens/home/widgets/home_screen_tab.dart';
import 'package:puntgpt_nick/screens/home/widgets/race_start_timing_options.dart';
import 'package:puntgpt_nick/screens/home/widgets/runners_list.dart';

import '../../provider/search_engine_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<SearchEngineProvider>(
        builder:
            (
              BuildContext context,
              SearchEngineProvider provider,
              Widget? child,
            ) {
              return Stack(
                children: [
                  Column(
                    spacing: 16,
                    children: [
                      //todo top 2 switch button
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 16, 25, 0),
                        child: HomeScreenTab(selectedTap: (index) {}),
                      ),
                      //todo timing buttons
                      RaceStartTimingOptions(),
                      Expanded(
                        child: (provider.isSearched)
                            ? RunnersList(runnerList: provider.runnersList)
                            : FilterList(formKey: formKey),
                      ),
                    ],
                  ),
                  if (provider.isSearched)
                    Align(
                      alignment: AlignmentGeometry.bottomCenter,
                      child: GestureDetector(
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
                                Text("Filter", style: medium(fontSize: 16.sp)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  context.pushNamed(AppRoutes.askPuntGpt.name);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12.r.flexClamp(12, 15),
                                    horizontal: 15.r.flexClamp(15, 18),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ImageWidget(
                                        path: AppAssets.horse,
                                        height: 30.w.flexClamp(28, 33),
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        "Ask @ PuntGPT",
                                        textAlign: TextAlign.center,
                                        style: semiBold(
                                          fontSize: 20.sp.flexClamp(18, 22),
                                          fontFamily: AppFontFamily.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            10.verticalSpace,
                            IntrinsicWidth(
                              child: AppFiledButton(
                                text: "Search",
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
              );
            },
      ),
    );
  }
}
