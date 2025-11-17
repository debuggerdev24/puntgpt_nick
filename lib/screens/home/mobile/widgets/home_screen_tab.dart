import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../../../../provider/search_engine_provider.dart';

class HomeScreenTab extends StatelessWidget {
  const HomeScreenTab({super.key, required this.selectedIndex, this.onTap});

  final int selectedIndex;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isMobile(context)
          ? double.maxFinite
          : 400.w.flexClamp(300, 500),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _tabButton(
              context: context,
              index: 0,
              text: "PuntGPT\nSearch Engine",
              isSelected: selectedIndex == 0,
            ),
            _tabButton(
              context: context,
              index: 1,
              text: "Classic Form Guide",
              isSelected: selectedIndex == 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton({
    required BuildContext context,
    required int index,
    required String text,
    required bool isSelected,
  }) {
    return Expanded(
      child: OnButtonTap(
        onTap: () {
          context.read<SearchEngineProvider>().changeTab = index;
          if (onTap != null && index == 0) {
            onTap!.call();
          }
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            border: Border.all(color: AppColors.primary),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: bold(
              fontSize: 16.sp,
              color: isSelected ? AppColors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
