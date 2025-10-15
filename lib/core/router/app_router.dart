// lib/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/features/splash/splash_screen.dart';

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
        pageBuilder: (context, state) =>
            NoTransitionPage(child: SplashScreen()),
      ),

      // ==================== AUTH ROUTES ====================
      // GoRoute(
      //   path: AppRoutes.login,
      //   name: AppRoutes.login,
      //   pageBuilder: (context, state) => NoTransitionPage(child: LoginScreen()),
      // ),
      // GoRoute(
      //   path: AppRoutes.signup,
      //   name: AppRoutes.signup,
      //   pageBuilder: (context, state) =>
      //       NoTransitionPage(child: SignupScreen()),
      // ),
      // GoRoute(
      //   path: AppRoutes.forgotPassword,
      //   name: AppRoutes.forgotPassword,
      //   pageBuilder: (context, state) =>
      //       NoTransitionPage(child: ForgotPasswordScreen()),
      // ),

      // ==================== MAIN APP WITH SHELL (Bottom Nav) ====================
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (context, state, child) {
      //     return SizedBox(child: child);
      //   },
      //   routes: [],
      // ),
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
