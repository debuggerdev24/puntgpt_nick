// lib/responsive/breakpoints.dart

/// Breakpoint constants for responsive design
class Breakpoints {
  // Mobile: 0 - 649px
  static const double mobile = 0;

  // Tablet: 650 - 1099px
  static const double tablet = 650;

  // Desktop: 1100px and above
  static const double desktop = 1100;

  // Large desktop: 1440px and above (optional)
  static const double largeDesktop = 1440;

  // Extra large desktop: 1920px and above (optional)
  static const double extraLargeDesktop = 1920;

  // Prevent instantiation
  Breakpoints._();
}

/// Responsive spacing values
class ResponsiveSpacing {
  // Horizontal padding
  static double horizontalPadding(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 32.0;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 24.0;
    } else {
      return 16.0;
    }
  }

  // Vertical padding
  static double verticalPadding(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 24.0;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 20.0;
    } else {
      return 16.0;
    }
  }

  // Card spacing
  static double cardSpacing(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 24.0;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 16.0;
    } else {
      return 12.0;
    }
  }

  // Section spacing
  static double sectionSpacing(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 48.0;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 32.0;
    } else {
      return 24.0;
    }
  }

  // Prevent instantiation
  ResponsiveSpacing._();
}

/// Responsive font sizes
class ResponsiveFontSizes {
  static double heading1(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 32.0;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 28.0;
    } else {
      return 24.0;
    }
  }

  static double heading2(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 24.0;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 22.0;
    } else {
      return 20.0;
    }
  }

  static double heading3(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 20.0;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 18.0;
    } else {
      return 16.0;
    }
  }

  static double body(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 16.0;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 15.0;
    } else {
      return 14.0;
    }
  }

  static double caption(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 14.0;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 13.0;
    } else {
      return 12.0;
    }
  }

  // Prevent instantiation
  ResponsiveFontSizes._();
}

/// Max content width for desktop
class MaxContentWidth {
  static const double small = 600; // For forms, cards
  static const double medium = 900; // For articles, profiles
  static const double large = 1200; // For dashboards, grids
  static const double extraLarge = 1440; // For full-width layouts

  // Prevent instantiation
  MaxContentWidth._();
}

/// Grid columns based on screen size
class ResponsiveGrid {
  static int columns(double screenWidth) {
    if (screenWidth >= Breakpoints.desktop) {
      return 12;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 8;
    } else {
      return 4;
    }
  }

  static int cardColumns(double screenWidth) {
    if (screenWidth >= Breakpoints.extraLargeDesktop) {
      return 4;
    } else if (screenWidth >= Breakpoints.desktop) {
      return 3;
    } else if (screenWidth >= Breakpoints.tablet) {
      return 2;
    } else {
      return 1;
    }
  }

  // Prevent instantiation
  ResponsiveGrid._();
}
