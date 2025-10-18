class AppRoutes {
  // Prevent instantiation
  AppRoutes._();

  static const String splash = '/splash';
  static const String ageConfirmationScreen = '/age-confirmation';
  static const String onboardingScreen = '/onboarding';

  // Auth
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Main tabs (Shell routes)
  static const String home = '/home';
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
