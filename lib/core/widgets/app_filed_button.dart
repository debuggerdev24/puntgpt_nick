import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

class AppFiledButton extends StatelessWidget {
  const AppFiledButton({
    super.key,
    required this.text,
    required this.onTap,
    this.padding,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    this.textStyle,
    this.margin,
  });

  final EdgeInsetsGeometry? padding, margin;
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
          margin: margin,
          padding:
              padding ??
              EdgeInsets.symmetric(
                vertical: 12.h, //r.flexClamp(10, 14),
                horizontal: 15.w, //r.flexClamp(13, 17),
              ),
          height: height,
          width: width ?? double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            color: color ?? AppColors.primary,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle ?? semiBold(fontSize: 20, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
