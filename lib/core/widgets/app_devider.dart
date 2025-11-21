import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

Divider appDivider({double? height,double? endIndent}) => Divider(
  color: AppColors.greyColor.withValues(alpha: 0.2),
  height: height ?? 1,
  endIndent: endIndent,
);
