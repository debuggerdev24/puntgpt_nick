enum WebRoutes { splashScreen, homeScreen, ageConfirmationScreen }

extension WebRouteExtension on WebRoutes {
  String get path => this == WebRoutes.homeScreen ? "/" : "/$name";
}
