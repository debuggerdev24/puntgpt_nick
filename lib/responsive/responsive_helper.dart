import 'dart:math' as math;

import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveUtils {
  // Breakpoints
  static const double mobileBreakpoint = 767;
  static const double tabletBreakpoint = 1024;

  /// Get the current device type based on screen width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= tabletBreakpoint) return DeviceType.desktop;
    if (width >= mobileBreakpoint) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  /// Responsive font size with min/max constraints and optimal scaling
  /// Usage: ResponsiveUtils.fontSize(context, mobile: 14, tablet: 16, desktop: 18, min: 12, max: 24)
  static double fontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? min,
    double? max,
    bool enableOptimalScaling = true,
  }) {
    final deviceType = getDeviceType(context);
    double calculatedSize;
    max = max ?? desktop ?? tablet ?? mobile;

    // Base calculation
    switch (deviceType) {
      case DeviceType.desktop:
        calculatedSize = desktop ?? tablet ?? mobile * 1.2;
        break;
      case DeviceType.tablet:
        calculatedSize = tablet ?? mobile * 1.1;
        break;
      case DeviceType.mobile:
        calculatedSize = mobile;
        break;
    }

    // Apply optimal scaling based on actual screen size
    if (enableOptimalScaling) {
      final screenWidth = MediaQuery.of(context).size.width;
      final scaleFactor = _getOptimalFontScaleFactor(screenWidth, deviceType);
      calculatedSize = calculatedSize * scaleFactor;
    }

    // Apply min/max constraints
    if (min != null && calculatedSize < min) {
      calculatedSize = min;
    }
    if (calculatedSize > max) {
      calculatedSize = max;
    }

    return calculatedSize;
  }

  /// Get optimal font scale factor based on actual screen width
  static double _getOptimalFontScaleFactor(
    double screenWidth,
    DeviceType deviceType,
  ) {
    switch (deviceType) {
      case DeviceType.desktop:
        // Scale between 1.0 (at 1024px) to 1.3 (at 1920px and beyond)
        if (screenWidth <= 1024) return 1.0;
        if (screenWidth >= 1920) return 1.3;
        return 1.0 + ((screenWidth - 1024) / (1920 - 1024)) * 0.3;

      case DeviceType.tablet:
        // Scale between 0.95 (at 768px) to 1.1 (at 1023px)
        if (screenWidth <= 768) return 0.95;
        if (screenWidth >= 1023) return 1.1;
        return 0.95 + ((screenWidth - 768) / (1023 - 768)) * 0.15;

      case DeviceType.mobile:
        // Scale between 0.9 (at 320px) to 1.0 (at 767px)
        if (screenWidth <= 320) return 0.9;
        if (screenWidth >= 767) return 1.0;
        return 0.9 + ((screenWidth - 320) / (767 - 320)) * 0.1;
    }
  }

  /// Responsive width with optional min/max limit
  /// Usage: ResponsiveUtils.width(context, mobile: 300, tablet: 400, desktop: 500, min: 250, max: 600)
  static double width(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? min,
    double? max,
  }) {
    final deviceType = getDeviceType(context);

    double value;
    switch (deviceType) {
      case DeviceType.desktop:
        value = desktop ?? tablet ?? mobile * 1.4;
        break;
      case DeviceType.tablet:
        value = tablet ?? mobile * 1.2;
        break;
      case DeviceType.mobile:
        value = mobile;
        break;
    }

    if (min != null) value = math.max(value, min);
    if (max != null) value = math.min(value, max);

    return value;
  }

  /// Responsive height with optional min/max limit
  /// Usage: ResponsiveUtils.height(context, mobile: 200, tablet: 250, desktop: 300, min: 180, max: 350)
  static double height(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? min,
    double? max,
  }) {
    final deviceType = getDeviceType(context);

    double value;
    switch (deviceType) {
      case DeviceType.desktop:
        value = desktop ?? tablet ?? mobile * 1.3;
        break;
      case DeviceType.tablet:
        value = tablet ?? mobile * 1.15;
        break;
      case DeviceType.mobile:
        value = mobile;
        break;
    }

    if (min != null) value = math.max(value, min);
    if (max != null) value = math.min(value, max);

    return value;
  }

  /// Responsive spacing (padding, margin, gaps) with optional min/max limit
  /// Usage: ResponsiveUtils.spacing(context, mobile: 16, tablet: 24, desktop: 32, min: 12, max: 40)
  static double spacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? min,
    double? max,
  }) {
    final deviceType = getDeviceType(context);

    double value;
    switch (deviceType) {
      case DeviceType.desktop:
        value = desktop ?? tablet ?? mobile * 1.5;
        break;
      case DeviceType.tablet:
        value = tablet ?? mobile * 1.25;
        break;
      case DeviceType.mobile:
        value = mobile;
        break;
    }

    if (min != null) value = math.max(value, min);
    if (max != null) value = math.min(value, max);

    return value;
  }

  /// Get screen width percentage
  /// Usage: ResponsiveUtils.widthPercent(context, 0.8) // 80% of screen width
  static double widthPercent(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent;
  }

  /// Get screen height percentage
  /// Usage: ResponsiveUtils.heightPercent(context, 0.5) // 50% of screen height
  static double heightPercent(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent;
  }

  /// Get responsive container constraints
  /// Usage: ResponsiveUtils.containerWidth(context, maxMobile: 350, maxTablet: 600, maxDesktop: 800)
  static double containerWidth(
    BuildContext context, {
    double? maxMobile,
    double? maxTablet,
    double? maxDesktop,
  }) {
    final deviceType = getDeviceType(context);
    final screenWidth = MediaQuery.of(context).size.width;

    switch (deviceType) {
      case DeviceType.desktop:
        return maxDesktop != null
            ? (screenWidth > maxDesktop ? maxDesktop : screenWidth * 0.9)
            : screenWidth * 0.8;
      case DeviceType.tablet:
        return maxTablet != null
            ? (screenWidth > maxTablet ? maxTablet : screenWidth * 0.95)
            : screenWidth * 0.9;
      case DeviceType.mobile:
        return maxMobile != null
            ? (screenWidth > maxMobile ? maxMobile : screenWidth * 0.95)
            : screenWidth * 0.9;
    }
  }

  /// Quick responsive value selector
  /// Usage: ResponsiveUtils.value(context, mobile: Colors.red, desktop: Colors.blue)
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.mobile:
        return mobile;
    }
  }

  /// Check if current device is mobile
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  /// Check if current device is tablet
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  /// Check if current device is desktop
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  /// Get responsive EdgeInsets
  /// Usage: ResponsiveUtils.padding(context, mobile: 16, tablet: 24, desktop: 32)
  static EdgeInsets padding(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final value = spacing(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
    return EdgeInsets.all(value);
  }

  /// Get responsive EdgeInsets with different horizontal and vertical values
  static EdgeInsets paddingSymmetric(
    BuildContext context, {
    required double mobileHorizontal,
    required double mobileVertical,
    double? tabletHorizontal,
    double? tabletVertical,
    double? desktopHorizontal,
    double? desktopVertical,
  }) {
    final horizontal = spacing(
      context,
      mobile: mobileHorizontal,
      tablet: tabletHorizontal,
      desktop: desktopHorizontal,
    );
    final vertical = spacing(
      context,
      mobile: mobileVertical,
      tablet: tabletVertical,
      desktop: desktopVertical,
    );
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }
}

// Extension for easier usage
extension ResponsiveExtension on BuildContext {
  ResponsiveUtils get responsive => ResponsiveUtils();

  double responsiveFontSize(
    double size, {
    double? tablet,
    double? desktop,
    double? min,
    double? max,
    bool enableOptimalScaling = true,
  }) => ResponsiveUtils.fontSize(
    this,
    mobile: size,
    tablet: tablet,
    desktop: desktop,
    min: min,
    max: max,
    enableOptimalScaling: enableOptimalScaling,
  );

  double responsiveWidth(
    double size, {
    double? tablet,
    double? desktop,
    double? max,
    double? min,
  }) => ResponsiveUtils.width(
    this,
    mobile: size,
    tablet: tablet,
    desktop: desktop,
    max: max,
    min: min,
  );

  double responsiveHeight(
    double size, {
    double? tablet,
    double? desktop,
    double? max,
    double? min,
  }) => ResponsiveUtils.height(
    this,
    mobile: size,
    tablet: tablet,
    desktop: desktop,
    max: max,
    min: min,
  );

  double responsiveSpacing({
    required double mobile,
    double? tablet,
    double? desktop,
    double? max,
    double? min,
  }) => ResponsiveUtils.spacing(
    this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
    max: max,
    min: min,
  );

  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
}
