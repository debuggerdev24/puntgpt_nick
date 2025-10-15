// lib/responsive/responsive_builder.dart

import 'package:flutter/material.dart';
import 'package:puntgpt_nick/core/extensions/context_extensions.dart';
import 'package:puntgpt_nick/responsive/breakpoints.dart';

/// Main responsive builder widget that renders different layouts
/// based on screen size
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context) desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (context.screenWidth >= Breakpoints.desktop) {
          return desktop(context);
        } else if (context.screenWidth >= Breakpoints.tablet &&
            tablet != null) {
          return tablet!(context);
        } else {
          return mobile(context);
        }
      },
    );
  }
}

/// Simpler responsive widget that takes widgets directly
class Responsive extends StatelessWidget {

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) =>
      context.screenWidth < Breakpoints.tablet;

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) =>
      context.screenWidth >= Breakpoints.tablet &&
      context.screenWidth < Breakpoints.desktop;

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) =>
      context.screenWidth >= Breakpoints.desktop;

  /// Get current device type
  static DeviceType getDeviceType(BuildContext context) {
    final width = context.screenWidth;
    if (width >= Breakpoints.desktop) return DeviceType.desktop;
    if (width >= Breakpoints.tablet) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (context.screenWidth >= Breakpoints.desktop) {
          return desktop;
        } else if (context.screenWidth >= Breakpoints.tablet &&
            tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// Device type enum
enum DeviceType { mobile, tablet, desktop }

/// Extension on BuildContext for easy responsive checks
extension ResponsiveContext on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  DeviceType get deviceType => Responsive.getDeviceType(this);
}

/// Responsive value builder - returns different values based on screen size
class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T desktop;

  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  T getValue(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return desktop;
    } else if (Responsive.isTablet(context) && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

/// Helper function to get responsive value
T responsiveValue<T>(
  BuildContext context, {
  required T mobile,
  T? tablet,
  required T desktop,
}) {
  if (Responsive.isDesktop(context)) {
    return desktop;
  } else if (Responsive.isTablet(context) && tablet != null) {
    return tablet;
  } else {
    return mobile;
  }
}
