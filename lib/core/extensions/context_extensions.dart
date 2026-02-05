import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
}
