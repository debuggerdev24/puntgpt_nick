class AppRoutes {
  // Prevent instantiation
  AppRoutes._();

  static const String splash = '/splash';
  static const String ageConfirmationScreen = '/age-confirmation';
  static const String onboardingScreen = '/onboarding';

  // Auth
  static const String loginScreen = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Main tabs (Shell routes)
  static const String dashBoard = '/dashboard';
  static const String home = '/home';
  static const String searchFilter = '/search-filter';
  static const String savedSearched = '/saved-search';
  static const String searchDetails = '/search-detail';
  static const String askPuntGpt = '/ask-punt-gpt';

  static const String changePassword = '/change-password';
  static const String tipSlipScreen = '/tip-slip';
  static const String selectedRace = '/selected-race';

  //2nd tab
  static const String puntGptClub = '/punt-gpt-club';
  static const String punterClubChatScreen = '/punter-club-chat';

  //3nd tab
  static const String bookies = '/bookies';

  //4th Account Tab
  static const String account = '/account';
  static const String personalDetailsScreen = '/personal-details';
  static const String manageSubscriptionScreen = '/manage-subscription';
}

extension AppRoutesExtension on String {
  /// Returns a formatted route name by converting a path into an underscore-separated string.
  ///
  /// This is useful when generating route `name` values for GoRouter.
  ///
  /// Example:
  /// ```dart
  /// const route = "/customer/home";
  /// print(route.name); // Output: "customer_home"
  ///
  /// const anotherRoute = "/auth/login";
  /// print(anotherRoute.name); // Output: "auth_login"
  /// ```
  String get name {
    if (this == "/") {
      return "home";
    }
    String s = startsWith('/') ? substring(1) : this;
    return s.split('/').join('_');
  }
}
