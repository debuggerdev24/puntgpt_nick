import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200.w.flexClamp(200, 250),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.setOpacity(0.2)),
      ),
      alignment: Alignment.center,
      child: Text(
        "Video",
        style: regular(
          fontSize: (kIsWeb) ? 62.sp : 32.sp,
          fontFamily: AppFontFamily.secondary,
        ),
      ),
    );
  }
}
