// lib/core/extensions/double_extension.dart

extension FlexibleClamp on double {
  /// Clamps this value between [min] and [max].
  ///
  /// - If [min] is `null`, there is no lower limit.
  /// - If [max] is `null`, there is no upper limit.
  ///
  /// Example:
  /// ```
  /// 280.w.flexClamp(min: 200, max: 350)
  /// ```
  double flexClamp([double? min, double? max]) {
    double value = this;

    if (min != null && value < min) value = min;
    if (max != null && value > max) value = max;

    return value;
  }
}
