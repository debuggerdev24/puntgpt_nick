import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/provider/search_engine_provider.dart';

class RaceStartTimingOptions extends StatelessWidget {
  const RaceStartTimingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchEngineProvider>(
      builder: (context, provider, _) {
        final timings = provider.raceStartingTimings;

        return LayoutBuilder(
          builder: (context, constraints) {
            // Estimate each item's average width based on text length and padding.
            // This avoids expensive measurement.
            final textScale = MediaQuery.of(context).textScaleFactor;
            double totalWidth = 50; // padding buffer
            for (final t in timings) {
              // roughly estimate width of each item
              final estimatedTextWidth = (t.length * 10 * textScale);
              totalWidth += estimatedTextWidth + 36 + 15; // padding + spacing
            }

            final fitsInScreen = totalWidth < constraints.maxWidth;

            return SizedBox(
              height: 45.w.flexClamp(45, 55),
              width: context.screenWidth,
              child: fitsInScreen
                  ? Center(
                      child: Wrap(
                        spacing: 15,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          timings.length,
                          (index) => _item(
                            text: timings[index],
                            onTap: () =>
                                provider.selectedRaceTimingIndex = index,
                            isSelected:
                                provider.selectedRaceTimingIndex == index,
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => _item(
                        text: timings[index],
                        onTap: () => provider.selectedRaceTimingIndex = index,
                        isSelected: provider.selectedRaceTimingIndex == index,
                      ),
                      separatorBuilder: (_, __) => const SizedBox(width: 15),
                      itemCount: timings.length,
                    ),
            );
          },
        );
      },
    );
  }

  Widget _item({
    required String text,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return OnButtonTap(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 450.ms,
        curve: Curves.decelerate,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.primary.setOpacity(0.15),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
        child: Text(
          text,
          style: semiBold(
            fontSize: 16,
            color: isSelected ? AppColors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
