import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

class WebTopSection extends StatelessWidget implements PreferredSizeWidget {
  const WebTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: AppColors.primary,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            "Visit UK Site",
            style: bold(fontSize: 12, color: AppColors.white),
          ),
          Container(color: AppColors.white, height: 2, width: 100),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.w.flexClamp(40, 45));
}
