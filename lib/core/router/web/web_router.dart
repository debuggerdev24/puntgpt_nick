import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/screens/splash/web_splash_screen.dart';

class WebRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static StatefulNavigationShell? indexedStackNavigationShell;

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: WebRoutes.splashScreen.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: WebRoutes.splashScreen.path,
        name: WebRoutes.splashScreen.name,
        builder: (context, state) => WebSplashScreen(),
      ),
    ],
  );
}
