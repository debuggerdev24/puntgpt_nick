enum WebRoutes {
  splashScreen,
  homeScreen,
  ageConfirmationScreen,
  onBoardingScreen,
  signUpScreen,
  logInScreen,
  selectedRace,
  tipSlipScreen,
  accountScreen,
  personalDetailsScreen,
  manageSubscriptionScreen,
  askOPuntGpt,
  savedSearched,
  punterClubScreen,
  punterClubChatScreen,
  bookiesScreen,
  subscribeToProPunterScreen,
  forgotPasswordScreen,
  verifyOTPScreen,
  resetPasswordScreen,
}

extension WebRouteExtension on WebRoutes {
  String get path => this == WebRoutes.homeScreen ? "/" : "/$name";
}
