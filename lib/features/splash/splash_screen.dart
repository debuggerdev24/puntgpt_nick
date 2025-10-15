import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/app_assets.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/extensions/double_extensions.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding:  EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 15.w.flexClamp(15, 25),
                  width: 15.w.flexClamp(15, 25),
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w.flexClamp(8, 12)),
                Container(
                  height: 15.w.flexClamp(15, 25),
                  width: 15.w.flexClamp(15, 25),
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w.flexClamp(8, 12)),
                Container(
                  height: 15.w.flexClamp(15, 25),
                  width: 15.w.flexClamp(15, 25),
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
