// lib/responsive/breakpoints.dart

/// Breakpoint constants for responsive design
class Breakpoints {
  Breakpoints._();
  // Mobile: 0 - 599 px
  static const double mobile = 0;

  /// Upper bound for narrow layout (`isMobile`: width \< this).
  /// `isMobileWeb` is: width **\>** [mobileWeb] and width \< [tablet] (see [Responsive.isMobileWeb]).
  /// iPhone 17 / 16 Pro Max portrait ≈ **440pt** — need [mobileWeb] \< 440 or `440 > mobileWeb` fails.
  static const double mobileWeb = 445;

  static const double tablet = 515;

  // Desktop: 1024 - 1439 px
  static const double desktop = 825;

  // Large desktop: 1440 - 1919 px
  static const double largeDesktop = 1440;

  // Extra-large desktop: 1920 px and above
  static const double extraLargeDesktop = 1920;
}
