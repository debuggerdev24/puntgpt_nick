// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startTimer();
      Future.delayed(
        3.seconds,
      ).then((value) => context.go(AppRoutes.ageConfirmationScreen));
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      currentIndex++;
      if (currentIndex > 2) {
        currentIndex = -1;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? null : WebTopSection(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(
              path: AppAssets.splashAppLogo,
              height: 200.w.flexClamp(200, 250),
            ).animate().fade(duration: 0.8.seconds, delay: 1.seconds),
            SizedBox(height: 20.w.flexClamp(20, 25)),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "'@PuntGPT'",
                    style: bold(fontSize: 20.sp.flexClamp(18, 22)),
                  ),
                  TextSpan(
                    text: " the talking from guide",
                    style: bold(fontSize: 20.sp.flexClamp(18, 22)),
                  ),
                ],
              ),
            ).animate().fade(duration: 0.8.seconds, delay: 1.3.seconds),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: context.bottomPadding > 0
                  ? context.bottomPadding + 20
                  : 30,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: 280.ms,
                  height: 15.w.flexClamp(15, 20),
                  width: 15.w.flexClamp(15, 20),
                  color: currentIndex >= 0
                      ? AppColors.primary
                      : AppColors.primary.setOpacity(0.1),
                ),
                SizedBox(width: 8.w.flexClamp(8, 12)),
                AnimatedContainer(
                  duration: 280.ms,
                  height: 15.w.flexClamp(15, 20),
                  width: 15.w.flexClamp(15, 20),
                  color: currentIndex >= 1
                      ? AppColors.primary
                      : AppColors.primary.setOpacity(0.1),
                ),
                SizedBox(width: 8.w.flexClamp(8, 12)),
                AnimatedContainer(
                  duration: 280.ms,
                  height: 15.w.flexClamp(15, 20),
                  width: 15.w.flexClamp(15, 20),
                  color: currentIndex == 2
                      ? AppColors.primary
                      : AppColors.primary.setOpacity(0.1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
