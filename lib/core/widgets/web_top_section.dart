import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

class WebTopSection extends StatelessWidget implements PreferredSizeWidget {
  const WebTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          "Visit UK Site",
          style: bold(fontSize: 12.sp.clamp(10, 14), color: AppColors.white),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.w.flexClamp(40, 45));
}
