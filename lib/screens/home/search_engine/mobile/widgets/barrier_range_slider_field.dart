import 'package:puntgpt_nick/core/app_imports.dart';

class BarrierRangeSliderField extends StatelessWidget {
  const BarrierRangeSliderField({
    super.key,
    required this.values,
    this.onChanged,
  });

  final RangeValues values; // stores indexes (0..5)
  final ValueChanged<RangeValues>? onChanged;

  // Single-value points shown on UI (no range labels). Last tick is shown as "16+".
  static const List<int> _points = [1, 4, 7, 10, 13, 16];

  static String _formatBarrierTick(int value) {
    if (value == _points.last) return '${_points.last}+';
    return '$value';
  }

  String _selectedText() {
    final start = values.start.round();
    final end = values.end.round();
    final lower = start <= end ? start : end;
    final upper = start <= end ? end : start;
    final minValue = _points[lower];
    final maxValue = _points[upper];
    final a = _formatBarrierTick(minValue);
    final b = _formatBarrierTick(maxValue);
    if (minValue == maxValue) return a;
    return "$a - $b";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14.wSize, bottom: 7.wSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Barrier",
                style: semiBold(
                  fontSize: (context.isMobileWeb)
                      ? 36.sp
                      : (kIsWeb)
                      ? 14
                      : 16.sp,
                ),
              ),
              Text(
                _selectedText(),
                style: medium(
                  fontSize: (context.isMobileWeb)
                      ? 30.sp
                      : (kIsWeb)
                      ? 14
                      : 16.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.wSize),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _points
                  .map(
                    (value) => Text(
                      _formatBarrierTick(value),
                      style: medium(
                        fontSize: (context.isMobileWeb)
                            ? 24.sp
                            : (kIsWeb)
                            ? 11
                            : 12.sp,
                        color: AppColors.primary.withValues(alpha: 0.8),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.greyColor,
              trackHeight: 4,
              thumbColor: Colors.white,
              overlayColor: AppColors.primary.withValues(alpha: 0.15),
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 10,
                elevation: 5,
                pressedElevation: 8,
              ),
              rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
              tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
              rangeTickMarkShape: const RoundRangeSliderTickMarkShape(
                tickMarkRadius: 0,
              ),
            ),
            child: RangeSlider(
              min: 0,
              max: 5,
              values: values,
              labels: RangeLabels(
                _formatBarrierTick(_points[values.start.round()]),
                _formatBarrierTick(_points[values.end.round()]),
              ),
              // 6 fixed points.
              divisions: 5,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
