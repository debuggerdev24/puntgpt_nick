import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({super.key, required this.selectedTap});

  final Function(int index) selectedTap;

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {
  int _selectedTab = 0;

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
              onTap: () => _onTabSelected(0),
              text: "PuntGPT\nSearch Engine",
              isSelected: _selectedTab == 0,
            ),
            _tabButton(
              onTap: () => _onTabSelected(1),
              text: "Classic Form Guide",
              isSelected: _selectedTab == 1,
            ),
          ],
        ),
      ),
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTab = index;
    });
    widget.selectedTap(index);
  }

  Widget _tabButton({
    required VoidCallback onTap,
    required String text,
    required bool isSelected,
  }) {
    return Expanded(
      child: OnButtonTap(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            border: Border.all(color: AppColors.primary),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: semiBold(
              fontSize: 14,
              color: isSelected ? AppColors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
