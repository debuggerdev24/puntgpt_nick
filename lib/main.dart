import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/router/web/web_router.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';
import 'package:puntgpt_nick/provider/punt_club/punter_club_provider.dart';
import 'package:puntgpt_nick/provider/search_engine_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => SearchEngineProvider()),
          ChangeNotifierProvider(create: (context) => AccountProvider()),
          ChangeNotifierProvider(create: (context) => PunterClubProvider()),
        ],
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: AppColors.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: true,
            designSize: (kIsWeb) ? Size(1440, 824) : const Size(430, 932),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.appThemeData,
              routerConfig: WebRouter
                  .router, //(kIsWeb) ? WebRouter.router : AppRouter.router,
            ),
          ),
        ),
      ),
    );
  }
}

/*
todo vimal



-> Worked on testing the iOS subscription.
-> Worked on updating the base url of the application.
-> Worked on testing the app feature with new base URL.
-> Worked on fixing context regarding issue in the app.

todo nick

-> Worked on developed the punt GPT punter club tab.
-> Worked on creating new branch for the new tab.
-> Worked on creating new custom widgets for the punter club section .
-> Worked on performing screens responsiveness.
-> Worked on added condition to close web popup when in mobile.
-> Worked on making responsive to the chat box.
*/
