import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/screens/auth/screens/web/web_login_screen.dart';
import 'package:puntgpt_nick/screens/auth/screens/web/web_sign_up_screen.dart';
import 'package:puntgpt_nick/screens/dashboard/web/web_dashboard.dart';
import 'package:puntgpt_nick/screens/home/web/home_screen_web.dart';
import 'package:puntgpt_nick/screens/onboarding/web/web_age_confirmation.dart';
import 'package:puntgpt_nick/screens/splash/web_splash_screen.dart';

import '../../../screens/home/web/selected_race_screen_web.dart';
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
      GoRoute(
        path: WebRoutes.signInScreen.path,
        name: WebRoutes.signInScreen.name,
        builder: (context, state) => WebLoginScreen(),
      ),

      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            indexedStackNavigationShell = navigationShell;
            return WebDashboard(
              // key: state.pageKey,
              navigationShell: indexedStackNavigationShell!,
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(routes: [
              GoRoute(
                path: WebRoutes.homeScreen.path,
                name: WebRoutes.homeScreen.name,
                builder: (context, state) => WebHomeScreen(),
              ),
              GoRoute(
                path: WebRoutes.selectedRace.path,
                name: WebRoutes.selectedRace.name,
                builder: (context, state) => SelectedRaceTableScreenWeb(),
              ),
            ])
      ])
    ],


    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Page not found: ${state.matchedLocation}'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.goNamed(WebRoutes.homeScreen.name),
              child: Text('Go Home'),
            ),
          ],
        ),
      ),
    ),

  );

}
