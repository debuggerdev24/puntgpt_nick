enum WebRoutes {
  splashScreen,
  homeScreen,
  ageConfirmationScreen,
  onBoardingScreen,
  signUpScreen,
}

extension WebRouteExtension on WebRoutes {
  String get path => this == WebRoutes.homeScreen ? "/" : "/$name";
}
