import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ResponsiveTextSize on int {
  double responsiveTextSize([double? min, double? max]) {
    return r
        .clamp(min ?? ((this - 2) <= 10 ? 10 : (this - 2)), max ?? (this + 2))
        .toDouble();
  }

  double responsiveSize([double? min, double? max]) {
    return w
        .clamp(min ?? ((this - 4) <= 8 ? 8 : (this - 4)), max ?? (this + 2))
        .toDouble();
  }

  double responsiveSpacing([double? min, double? max]) {
    return w
        .clamp(min ?? ((this - 5) <= 5 ? 5 : (this - 5)), max ?? (this + 5))
        .toDouble();
  }
}

extension FlexibleClamp on double {
  double flexClamp([double? min, double? max]) {
    double value = this;

    if (min != null && value < min) value = min;
    if (max != null && value > max) value = max;

    return value;
  }
}
