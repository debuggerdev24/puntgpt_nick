import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';
import 'package:puntgpt_nick/core/widgets/web_top_section.dart';

import '../../service/storage/locale_storage_service.dart';

class WebSplashScreen extends StatefulWidget {
  const WebSplashScreen({super.key});

  @override
  State<WebSplashScreen> createState() => _WebSplashScreenState();
}

class _WebSplashScreenState extends State<WebSplashScreen> {
  String authToken = LocaleStorageService.userToken;

  Timer? _timer;
  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    Logger.info("Authorized Token : $authToken");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startTimer();
      Future.delayed(3.seconds).then((value) {
        if (LocaleStorageService.isFirstTime && authToken.isEmpty) {
          Logger.info("Inside if part");
          context.goNamed(WebRoutes.ageConfirmationScreen.name);
          return;
        }
        Logger.info("Inside else part");
        //todo here I need to decide the which screen need to show first
        context.goNamed(WebRoutes.homeScreen.name);
        return;
      });
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
      appBar: WebTopSection(),
      body: Center(
        child: Column(
          crossAxisAlignment: kIsWeb
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(
              path: AppAssets.splashWebLogo,
              type: ImageType.asset,
              width: 300.w,
            ).animate().fade(duration: 0.8.seconds, delay: 1.seconds),
            24.h.flexClamp(20, 28).verticalSpace,
            Text(
              "A new way of betting here",
              style: medium(
                fontFamily: AppFontFamily.secondary,
                fontSize: 20.sp,
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "'@PuntGPT'",
                    style: regular(
                      fontSize: 24.sp,
                      fontFamily: AppFontFamily.secondary,
                    ),
                  ),
                  TextSpan(
                    text: " the talking from guide",
                    style: regular(
                      fontSize: 24.sp,
                      fontFamily: AppFontFamily.secondary,
                    ),
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
