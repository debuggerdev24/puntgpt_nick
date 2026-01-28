import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
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
    this.isExpand,
    this.child,
  });

  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;
  final double? height;
  final double? width;
  final double? borderRadius;
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final Color? color;
  final bool? isExpand;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: margin,
          alignment: AlignmentGeometry.center,
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
          height: height,
          width: (width == null)
              ? (isExpand ?? true)
                    ? double.maxFinite
                    : null
              : width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            color: color ?? AppColors.primary,
          ),
          child:
              child ??
              Text(
                text,
                textAlign: TextAlign.center,
                style:
                    textStyle ??
                    semiBold(fontSize: 18.sp, color: AppColors.white),
              ),
        ),
      ),
    );
  }
}
