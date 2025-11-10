import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

Divider appDivider({double? height}) => Divider(color: AppColors.dividerColor.withValues(alpha: 0.2),height: height ?? 1,);
