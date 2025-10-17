// lib/routes/app_router.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/screens/auth/screens/login_screen.dart';
import 'package:puntgpt_nick/screens/auth/screens/sign_up_screen.dart';
import 'package:puntgpt_nick/screens/dashboard/dashboard.dart';
import 'package:puntgpt_nick/screens/home/home_screen.dart';
import 'package:puntgpt_nick/screens/onboarding/age_confirmation_screen.dart';
import 'package:puntgpt_nick/screens/onboarding/onboarding_screen.dart';
import 'package:puntgpt_nick/screens/onboarding/web_onboarding_screen.dart';
import 'package:puntgpt_nick/screens/splash/splash_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.splash,

    // Redirect logic for authentication
    // redirect: (context, state) {
    //   final isLoggedIn = AuthService.instance.isLoggedIn;
    //   final isLoggingIn =
    //       state.matchedLocation == AppRoutes.login ||
    //       state.matchedLocation == AppRoutes.signup ||
    //       state.matchedLocation == AppRoutes.forgotPassword;

    //   // If not logged in and not on auth pages, redirect to login
    //   if (!isLoggedIn && !isLoggingIn) {
    //     return AppRoutes.login;
    //   }

    //   // If logged in and on auth pages, redirect to home
    //   if (isLoggedIn && isLoggingIn) {
    //     return AppRoutes.home;
    //   }

    //   return null; // No redirect neededY
    // },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) => SplashScreen(),
      ),

      GoRoute(
        path: AppRoutes.ageConfirmationScreen,
        name: AppRoutes.ageConfirmationScreen,
        builder: (context, state) => AgeConfirmationScreen(),
      ),

      GoRoute(
        path: AppRoutes.onboardingScreen,
        name: AppRoutes.onboardingScreen,
        builder: (context, state) =>
            kIsWeb ? WebOnboardingScreen() : OnboardingScreen(),
      ),

      // ==================== AUTH ROUTES ====================
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) =>
            LoginScreen(isFreeSignUp: (state.extra as Map)['is_free_sign_up']),
      ),

      GoRoute(
        path: AppRoutes.signup,
        name: AppRoutes.signup,
        builder: (context, state) =>
            SignUpScreen(isFreeSignUp: (state.extra as Map)['is_free_sign_up']),
      ),

      // ==================== MAIN APP WITH SHELL (Bottom Nav) ====================
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Dashboard(navigationShell: navigationShell);
        },
        branches: [
          // home screen
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.home,
                builder: (context, state) => HomeScreen(),
              ),
            ],
          ),
        ],
      ),
    ],

    // Error page
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
              onPressed: () => context.go(AppRoutes.home),
              child: Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
