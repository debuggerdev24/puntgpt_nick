class AppRoutes {
  // Auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Main tabs (Shell routes)
  static const String home = '/home';
  static const String cards = '/cards';
  static const String mugPunter = '/mug-punter';
  static const String proPunter = '/pro-punter';
  static const String profile = '/profile';

  // Card routes
  static const String cardDetails = '/card-details';
  static const String cardSearch = '/card-search';
  static const String cardCategory = '/card-category';

  // Reminder routes
  static const String reminders = '/reminders';
  static const String addReminder = '/add-reminder';
  static const String editReminder = '/edit-reminder';

  // Profile routes
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';

  // Prevent instantiation
  AppRoutes._();
}
