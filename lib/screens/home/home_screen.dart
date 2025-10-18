import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/home/widgets/filters_list.dart';
import 'package:puntgpt_nick/screens/home/widgets/home_screen_tab.dart';
import 'package:puntgpt_nick/screens/home/widgets/race_start_timing_options.dart';

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
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(35, 16, 35, 0),
                child: HomeScreenTab(selectedTap: (index) {}),
              ),
              SizedBox(height: 16),
              RaceStartTimingOptions(),
              SizedBox(height: 16),
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        25,
                        0,
                        25,
                        Responsive.isMobile(context)
                            ? !_keyboardVisible
                                  ? 150
                                  : 20
                            : 30,
                      ),
                      child: Column(
                        children: [
                          FilterList(formKey: formKey),
                          SizedBox(height: 50.w.flexClamp(40, 50)),
                          Text(
                            "Pick as many or few filters, hit search, find YOUR horses and\nask PuntGPT to analyse and compare to the field",
                            textAlign: TextAlign.center,
                            style: medium(
                              fontSize: 14.sp.clamp(12, 16),
                              color: AppColors.black.setOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: 60.w.flexClamp(50, 70)),
                          AppFiledButton(
                            width: 120.w.flexClamp(110, 130),
                            text: "Search",
                            onTap: () {},
                          ),
                          SizedBox(height: 20.w.flexClamp(15, 25)),
                          Text(
                            "Search Results: (20)",
                            textAlign: TextAlign.center,
                            style: medium(
                              fontSize: 16.sp.clamp(14, 18),
                              color: AppColors.black.setOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ✅ Hide buttons when keyboard is visible
                    if (!_keyboardVisible &&
                        (Responsive.isMobile(context) ||
                            Responsive.isTablet(context)))
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {},
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
                                        SizedBox(width: 10),
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
                              SizedBox(height: 10),
                              IntrinsicWidth(
                                child: AppFiledButton(
                                  text: "Search",
                                  onTap: () {
                                    formKey.currentState!.validate();
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (Responsive.isDesktop(context)) ...[
            Positioned(
              bottom: 30,
              right: 30,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.r.flexClamp(12, 15),
                      horizontal: 15.r.flexClamp(15, 18),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageWidget(
                          path: AppAssets.horse,
                          height: 30.w.flexClamp(28, 33),
                        ),
                        SizedBox(width: 10),
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
            ),
          ],
        ],
      ),
    );
  }
}
