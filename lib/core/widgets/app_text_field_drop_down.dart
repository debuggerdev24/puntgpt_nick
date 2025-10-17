import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';

class AppTextFieldDropdown extends StatelessWidget {
  const AppTextFieldDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChange,
    required this.hintText,
    this.hintStyle,
    this.textStyle,
    this.errorStyle,
    this.borderRadius,
    this.validator,
    this.autovalidateMode,
  });

  final List<String> items;
  final String? selectedValue;
  final Function(String) onChange;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final double? borderRadius;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: selectedValue);

    return GestureDetector(
      onTap: () => _showDropdownMenu(context),
      child: AbsorbPointer(
        child: AppTextField(
          controller: controller,
          hintText: hintText,
          validator: validator,
          textStyle: textStyle,
          hintStyle: hintStyle,
          errorStyle: errorStyle,
          borderRadius: borderRadius,
          autovalidateMode: autovalidateMode,
          trailingIcon: AppAssets.arrowDown,
        ),
      ),
    );
  }

  Future<void> _showDropdownMenu(BuildContext context) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext dialogContext) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(dialogContext),
                behavior: HitTestBehavior.opaque,
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy + (size.height / 2),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
                color: AppColors.white,
                child: Container(
                  width: size.width,
                  constraints: BoxConstraints(maxHeight: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius ?? 0),
                    color: AppColors.white,
                    border: Border.all(
                      color: AppColors.primary.setOpacity(0.1),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = item == selectedValue;

                      return InkWell(
                        onTap: () {
                          onChange(item);
                          Navigator.pop(dialogContext);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.setOpacity(0.1)
                                : Colors.transparent,
                          ),
                          child: Text(
                            item,
                            style:
                                textStyle ??
                                medium(
                                  fontSize: 16.sp.clamp(14, 18),
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.black,
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
