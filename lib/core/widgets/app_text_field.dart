import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.hintStyle,
    this.textStyle,
    this.errorStyle,
    this.borderRadius,
    this.trailingIcon,
    this.onTrailingIconTap,
    this.validator,
    this.autovalidateMode,
    this.onTap,
    this.enabled = true,
    this.suffix,
    this.inputFormatter,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final Widget? suffix;
  final double? borderRadius;
  final bool obscureText;
  final dynamic trailingIcon;
  final VoidCallback? onTrailingIconTap;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final VoidCallback? onTap;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String? _currentError;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      controller: widget.controller,
      cursorColor: AppColors.primary,
      style: widget.textStyle ?? medium(fontSize: 16),
      obscureText: widget.obscureText,
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatter,
      keyboardType: widget.keyboardType,
      validator: (value) {
        final error = widget.validator?.call(value);
        // if (mounted && _currentError != error) {
        //   Future.microtask(() {
        //     if (mounted && _currentError != error) {
        //       setState(() => _currentError = error);
        //     }
        //   });
        // }
        return error;
      },

      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints(
          maxHeight: 26.h.flexClamp(24, 28),
          minHeight: 26.h.flexClamp(24, 28),
          maxWidth: 26.w.flexClamp(24, 28) + 20,
          minWidth: 26.w.flexClamp(24, 28) + 20,
        ),
        suffixIcon: widget.trailingIcon == null
            ? const SizedBox()
            : GestureDetector(
                onTap: widget.onTrailingIconTap,
                child: ImageWidget(
                  type: ImageType.svg,
                  path: widget.trailingIcon!,
                ),
              ),
        hintText: widget.hintText,
        hintStyle:
            widget.hintStyle ??
            medium(fontSize: 14, color: AppColors.primary.setOpacity(0.4)),
        errorStyle:
            widget.errorStyle ?? medium(fontSize: 13, color: AppColors.red),
        errorMaxLines: 5,
        // error: _currentError == null
        //     ? null
        //     : Transform.translate(
        //         offset: const Offset(-20, 0),
        //         child: Text(
        //           _currentError!,
        //           style:
        //               widget.errorStyle ??
        //               medium(fontSize: 12, color: AppColors.red),
        //         ),
        //       ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 17,
        ),
        isDense: true,
        filled: true,
        fillColor: AppColors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          borderSide: BorderSide(color: AppColors.primary.setOpacity(0.1)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          borderSide: BorderSide(color: AppColors.primary.setOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          borderSide: BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          borderSide: BorderSide(color: AppColors.red),
        ),
      ),
    );
  }
}
