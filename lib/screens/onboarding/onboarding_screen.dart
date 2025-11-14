import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';
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
            40.h.verticalSpace,
            VideoWidget(),
            40.h.verticalSpace,
            Plans(
              currentPlan: (index) {
                _currentIndex = index;
                setState(() {});
              },
              data: planData,
              selectedIndex: _currentIndex,
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
                context.read<AuthProvider>().clearSignUpControllers();

                context.push(
                  AppRoutes.signup,
                  extra: {'is_free_sign_up': _currentIndex == 0},
                );
                context.read<AuthProvider>().clearSignUpControllers();
              },
            ),
            12.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                planData.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 15.w,
                    width: 15.w,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? AppColors.primary
                          : AppColors.primary.setOpacity(0.3),
                    ),
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
