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
    SystemUiOverlayStyle(
      statusBarColor: Colors.black,
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
              routerConfig: (kIsWeb) ? WebRouter.router : AppRouter.router,
            ),
          ),
        ),
      ),
    );
  }
}

/*
todo nick


flutter run --release -d web-server --web-port=5000 --web-hostname=0.0.0.0

todo Vimal

*/
