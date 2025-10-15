import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.padding,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    this.textStyle,
  });

  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final double? borderRadius;
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              padding ??
              EdgeInsets.symmetric(
                vertical: 12.r.flexClamp(12, 15),
                horizontal: 15.r.flexClamp(15, 18),
              ),
          height: height,
          width: width ?? double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            color: AppColors.white,
            border: Border.all(color: color ?? AppColors.primary),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style:
                textStyle ??
                semiBold(
                  fontSize: 20.sp.flexClamp(18, 22),
                  color: AppColors.primary,
                ),
          ),
        ),
      ),
    );
  }
}
