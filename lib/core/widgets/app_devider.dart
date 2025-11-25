import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

Divider horizontalDivider({double? height,double? endIndent}) => Divider(
  color: AppColors.greyColor.withValues(alpha: 0.2),
  height: height ?? 1,
  endIndent: endIndent,
);

Widget verticalDivider({double? height, double? width, double? indent, double? endIndent}) {
  return height == null
      ? VerticalDivider(
    color: AppColors.greyColor.withValues(alpha: 0.2),
    width: width ?? 1,
    indent: indent,
    endIndent: endIndent,
  )
      : SizedBox(
    height: height,
    child: VerticalDivider(
      color: AppColors.greyColor.withValues(alpha: 0.2),
      width: width ?? 1,
    ),
  );
}
