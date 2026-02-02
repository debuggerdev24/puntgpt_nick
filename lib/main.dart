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
import 'package:puntgpt_nick/provider/subscription/subscription_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/service/network/network_service.dart';
import 'package:puntgpt_nick/service/storage/locale_storage_service.dart';
import 'package:toastification/toastification.dart';
import 'core/router/app/app_router.dart';

ValueNotifier<bool> isNetworkConnected = ValueNotifier(true);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Future.wait([LocaleStorageService.init()]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: false,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(ToastificationWrapper(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    checkConnectivity(context: context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => SearchEngineProvider()),
          ChangeNotifierProvider(create: (context) => AccountProvider()),
          ChangeNotifierProvider(create: (context) => PunterClubProvider()),
          ChangeNotifierProvider(create: (context) => SubscriptionProvider()),
        ],
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: AppColors.primary, // Your desired color
            systemStatusBarContrastEnforced: false, // Critical for Android 13+
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
          ),

          child: ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: true,
            designSize: (context.isPhysicalMobile)
                ? Size(430, 932)
                : Size(1440, 824),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.appThemeData,
              routerConfig: (kIsWeb) ? WebRouter.router : AppRouter.router,
            ),
          ),
        ),
      ),
    );
  }
}

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3MDgxNDUzLCJpYXQiOjE3NjcwMDk0NTMsImp0aSI6IjRmYWI1NzYzYTk2YjRkZWQ4YzUwOTgwZDQ1YTZjNmFmIiwidXNlcl9pZCI6IjMifQ.CngkGuLvXKSJPf0iMxqIb86Mp4aortWuZ-x8Ko3Ci8s

/*

todo Joseph

-> Worked on added the all countries inside the profile section.
-> Worked on update the navigation and showing subscription and success screen.
-> Worked on updated the add topic feature inside the topic screen and placed the new topic at first.
-> Worked on update the reset password validation and added the condition to to display the proper error message from the backend.


todo Nick



Web side



flutter run --release -d web-server --web-port=5000 --web-hostname=0.0.0.0
// http://192.168.1.104:5000/#/splashScreen

*/
