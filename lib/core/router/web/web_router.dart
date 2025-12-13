import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/web/web_routes.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/account/mobile/account_screen.dart';
import 'package:puntgpt_nick/screens/account/mobile/manage_subscription_screen.dart';
import 'package:puntgpt_nick/screens/account/mobile/personal_details_screen.dart';
import 'package:puntgpt_nick/screens/auth/screens/web/web_login_screen.dart';
import 'package:puntgpt_nick/screens/auth/screens/web/web_sign_up_screen.dart';
import 'package:puntgpt_nick/screens/dashboard/web/web_dashboard.dart';
import 'package:puntgpt_nick/screens/home/web/home_screen_web.dart';
import 'package:puntgpt_nick/screens/home/web/tip_slip_screen_web.dart';
import 'package:puntgpt_nick/screens/onboarding/web/web_age_confirmation.dart';
import 'package:puntgpt_nick/screens/punt_gpt_club/mobile/punter_club_screen.dart';
import 'package:puntgpt_nick/screens/punt_gpt_club/web/punter_club_screen_web.dart';
import 'package:puntgpt_nick/screens/splash/web_splash_screen.dart';

import '../../../screens/account/web/account_screen_web.dart';
import '../../../screens/bookies/web/bookies_screen_web.dart';
import '../../../screens/home/mobile/ask_punt_gpt.dart';
import '../../../screens/home/mobile/saved_search_screen.dart';
import '../../../screens/home/web/selected_race_screen_web.dart';
import '../../../screens/onboarding/web/web_onboarding_screen.dart';
import '../../../screens/punt_gpt_club/mobile/punt_club_chat_screen.dart';

class WebRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static StatefulNavigationShell? indexedStackNavigationShell;

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: WebRoutes.homeScreen.path,
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
          //todo home branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: WebRoutes.homeScreen.path,
                name: WebRoutes.homeScreen.name,
                builder: (context, state) => HomeScreenWeb(),
              ),
              GoRoute(
                path: WebRoutes.selectedRace.path,
                name: WebRoutes.selectedRace.name,
                builder: (context, state) => SelectedRaceTableScreenWeb(),
              ),
              GoRoute(
                path: WebRoutes.askOPuntGpt.path,
                name: WebRoutes.askOPuntGpt.name,
                builder: (context, state) => AskPuntGptScreen(),
              ),
              GoRoute(
                name: WebRoutes.savedSearched.name,
                path: WebRoutes.savedSearched.path,
                builder: (BuildContext context, GoRouterState state) {
                  return SavedSearchScreen();
                },
              ),
            ],
          ),
          //todo Punter Club branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: WebRoutes.punterClubScreen.path,
                name: WebRoutes.punterClubScreen.name,
                builder: (context, state) => context.isMobile
                    ? PunterClubScreen()
                    : PunterClubScreenWebScreen(),
              ),
              GoRoute(
                path: WebRoutes.punterClubChatScreen.path,
                name: WebRoutes.punterClubChatScreen.name,
                builder: (context, state) =>
                    PuntClubChatScreen(title: state.extra as String),
              ),
            ],
          ),
          //todo tip slip branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: WebRoutes.tipSlipScreen.path,
                name: WebRoutes.tipSlipScreen.name,
                builder: (context, state) => TipSlipScreenWeb(),
              ),
            ],
          ),
          //todo account branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: WebRoutes.accountScreen.path,
                name: WebRoutes.accountScreen.name,
                builder: (context, state) =>
                    (context.isMobile) ? AccountScreen() : AccountScreenWeb(),
              ),
              GoRoute(
                path: WebRoutes.personalDetailsScreen.path,
                name: WebRoutes.personalDetailsScreen.name,
                builder: (context, state) => (context.isMobile)
                    ? PersonalDetailsScreen()
                    : AccountScreenWeb(),
              ),
              GoRoute(
                path: WebRoutes.manageSubscriptionScreen.path,
                name: WebRoutes.manageSubscriptionScreen.name,
                builder: (context, state) => (context.isMobile)
                    ? ManageSubscriptionScreen()
                    : AccountScreenWeb(),
              ),
            ],
          ),
          //todo bookies branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: WebRoutes.bookiesScreen.path,
                name: WebRoutes.bookiesScreen.name,
                builder: (context, state) => BookiesScreenWeb(),
              ),
            ],
          ),
        ],
      ),
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
