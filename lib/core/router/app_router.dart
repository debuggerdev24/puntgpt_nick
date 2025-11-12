// lib/routes/app_router.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/app_routes.dart';
import 'package:puntgpt_nick/screens/account/account_screen.dart';
import 'package:puntgpt_nick/screens/account/change_password_screen.dart';
import 'package:puntgpt_nick/screens/account/manage_subscription_screen.dart';
import 'package:puntgpt_nick/screens/account/personal_details_screen.dart';
import 'package:puntgpt_nick/screens/auth/screens/login_screen.dart';
import 'package:puntgpt_nick/screens/auth/screens/sign_up_screen.dart';
import 'package:puntgpt_nick/screens/bookies/bookies_screen.dart';
import 'package:puntgpt_nick/screens/home/ask_punt_gpt.dart';
import 'package:puntgpt_nick/screens/home/home_screen.dart';
import 'package:puntgpt_nick/screens/home/manage_saved_search.dart';
import 'package:puntgpt_nick/screens/home/saved_search_screen.dart';
import 'package:puntgpt_nick/screens/home/search_filter_screen.dart';
import 'package:puntgpt_nick/screens/home/selected_race_screen.dart';
import 'package:puntgpt_nick/screens/onboarding/age_confirmation_screen.dart';
import 'package:puntgpt_nick/screens/onboarding/onboarding_screen.dart';
import 'package:puntgpt_nick/screens/onboarding/web_onboarding_screen.dart';
import 'package:puntgpt_nick/screens/punt_gpt_club/punter_club_screen.dart';
import 'package:puntgpt_nick/screens/splash/splash_screen.dart';

import '../../screens/dashboard/dashboard.dart';
import '../../screens/home/tip_slip_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static StatefulNavigationShell? indexedStackNavigationShell;

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
        name: AppRoutes.splash.name,
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

      GoRoute(
        name: AppRoutes.searchFilter.name,
        path: AppRoutes.searchFilter,
        builder: (context, state) {
          return SearchFilterScreen();
        },
      ),

      // ==================== MAIN APP WITH SHELL (Bottom Nav) ====================
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          indexedStackNavigationShell = navigationShell;
          return Dashboard(
            // key: state.pageKey,
            navigationShell: indexedStackNavigationShell!,
          );
        },
        branches: <StatefulShellBranch>[
          //todo ----------> Customer Home Tab
          StatefulShellBranch(
            // navigatorKey: _shellNavigatorCustomerHome,
            routes: <RouteBase>[
              GoRoute(
                name: AppRoutes.home.name,
                path: AppRoutes.home,
                builder: (BuildContext context, GoRouterState state) {
                  return HomeScreen();
                },
              ),
              GoRoute(
                name: AppRoutes.savedSearched.name,
                path: AppRoutes.savedSearched,
                builder: (BuildContext context, GoRouterState state) {
                  return SavedSearchScreen();
                },
              ),
              GoRoute(
                name: AppRoutes.searchDetails.name,
                path: AppRoutes.searchDetails,
                builder: (BuildContext context, GoRouterState state) {
                  return SearchDetailScreen();
                },
              ),
              GoRoute(
                name: AppRoutes.askPuntGpt.name,
                path: AppRoutes.askPuntGpt,
                builder: (BuildContext context, GoRouterState state) {
                  return AskPuntGpt();
                },
              ),
              GoRoute(
                name: AppRoutes.selectedRace.name,
                path: AppRoutes.selectedRace,
                builder: (BuildContext context, GoRouterState state) {
                  return SelectedRaceScreen();
                },
              ),
            ],
          ),

          //todo ----------> PuntGPT Punter Club Tab
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.puntGptClub,
                name: AppRoutes.puntGptClub.name,
                builder: (context, state) => PunterClubScreen(),
              ),
            ],
          ),

          //todo ----------> Bookies Tab
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.bookies,
                name: AppRoutes.bookies.name,
                builder: (context, state) => BookiesScreen(),
              ),
            ],
          ),
          //todo ----------> Customer Account Tab
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: AppRoutes.account.name,
                path: AppRoutes.account,
                builder: (BuildContext context, GoRouterState state) {
                  return AccountScreen();
                },
              ),
              GoRoute(
                name: AppRoutes.personalDetails.name,
                path: AppRoutes.personalDetails,
                builder: (BuildContext context, GoRouterState state) {
                  return PersonalDetailsScreen();
                },
              ),
              GoRoute(
                name: AppRoutes.manageSubscription.name,
                path: AppRoutes.manageSubscription,
                builder: (BuildContext context, GoRouterState state) {
                  return ManageSubscriptionScreen();
                },
              ),
              GoRoute(
                name: AppRoutes.changePassword.name,
                path: AppRoutes.changePassword,
                builder: (BuildContext context, GoRouterState state) {
                  return ChangePasswordScreen();
                },
              ),
              GoRoute(
                name: AppRoutes.tipSlip.name,
                path: AppRoutes.tipSlip,
                builder: (BuildContext context, GoRouterState state) {
                  return TipSlipScreen();
                },
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
