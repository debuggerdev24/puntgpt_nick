enum WebRoutes {
  splashScreen,
  homeScreen,
  ageConfirmationScreen,
  onBoardingScreen,
  signUpScreen,
  signInScreen,
  selectedRace,
  tipSlipScreen,
  accountScreen,
  personalDetailsScreen,
  manageSubscriptionScreen,
}

extension WebRouteExtension on WebRoutes {
  String get path => this == WebRoutes.homeScreen ? "/" : "/$name";
}
