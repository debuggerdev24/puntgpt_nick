import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/screens/onboarding/widgets/plans.dart';
import 'package:puntgpt_nick/screens/onboarding/widgets/video_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Map> planData = [
    {
      "title": "Free 'Mug Punter' Account",
      "price": "",
      "points": [
        {"icon": AppAssets.delete, "text": "No chat function with PuntGPT"},
        {"icon": AppAssets.delete, "text": "No access to PuntGPT Punters Club"},
        {
          "icon": AppAssets.done,
          "text": "Limited PuntGPT Search Engine Filters",
        },
        {"icon": AppAssets.done, "text": "Limited AI analysis of horses"},
        {"icon": AppAssets.done, "text": "Access to Classic Form Guide"},
      ],
    },
    {
      "title": "Monthly",
      "price": "9.99",
      "points": [
        {"icon": AppAssets.done, "text": "Chat function with PuntGPT"},
        {"icon": AppAssets.done, "text": "Access to PuntGPT Punters Club"},
        {"icon": AppAssets.done, "text": "Full use of PuntGPT Search Engine"},
        {"icon": AppAssets.done, "text": "Access to Classic Form Guide"},
      ],
    },
    {
      "title": "Yearly",
      "price": "59.99",
      "points": [
        {"icon": AppAssets.done, "text": "Chat function with PuntGPT"},
        {"icon": AppAssets.done, "text": "Access to PuntGPT Punters Club"},
        {"icon": AppAssets.done, "text": "Full use of PuntGPT Search Engine"},
        {"icon": AppAssets.done, "text": "Access to Classic Form Guide"},
      ],
    },
    {
      "title": "Lifetime",
      "price": "159.99",
      "points": [
        {"icon": AppAssets.done, "text": "Chat function with PuntGPT"},
        {"icon": AppAssets.done, "text": "Access to PuntGPT Punters Club"},
        {"icon": AppAssets.done, "text": "Full use of PuntGPT Search Engine"},
        {"icon": AppAssets.done, "text": "Access to Classic Form Guide"},
      ],
    },
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Video area fills remaining height
            SizedBox(height: 40),
            VideoWidget(),

            SizedBox(height: 40.w.flexClamp(35, 40)),
            Plans(
              currentPlan: (index) {
                _currentIndex = index;
                setState(() {});
              },
              data: planData,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, context.bottomPadding + 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppFiledButton(
              text: _currentIndex == 0
                  ? "Continue with Free Account"
                  : "Subscribe",
              onTap: () {
                context.push(
                  AppRoutes.signup,
                  extra: {'is_free_sign_up': _currentIndex == 0},
                );
              },
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                planData.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 15.w.flexClamp(15, 20),
                  width: 15.w.flexClamp(15, 20),
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.primary.setOpacity(0.3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
