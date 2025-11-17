import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/screens/auth/screens/web/web_signUp_screen.dart';
import 'package:puntgpt_nick/screens/onboarding/web/web_age_confirmation.dart';
import 'package:puntgpt_nick/screens/splash/web_splash_screen.dart';

import '../../../screens/onboarding/web/web_onboarding_screen.dart';

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
      GoRoute(
        path: WebRoutes.onBoardingScreen.path,
        name: WebRoutes.onBoardingScreen.name,
        builder: (context, state) => WebOnboardingScreen(),
      ),
      GoRoute(
        path: WebRoutes.ageConfirmationScreen.path,
        name: WebRoutes.ageConfirmationScreen.name,
        builder: (context, state) => WebAgeConfirmationScreen(),
      ),
      GoRoute(
        path: WebRoutes.signUpScreen.path,
        name: WebRoutes.signUpScreen.name,
        builder: (context, state) =>
            WebSignUpScreen(isFreeSignUp: state.extra as bool),
      ),
    ],
  );
}
