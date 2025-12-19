import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/app_assets.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';

class BookiesScreen extends StatelessWidget {
  const BookiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 32.h,
        children: [
          SizedBox(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Use Code: ",
                  style: bold(fontSize: 20.sp),
                ),
                TextSpan(
                  text: "‘PUNTGPT’",
                  style: bold(fontSize: 20.sp, color: Color(0xffE5B82E)),
                ),
              ],
            ),
          ),
          ImageWidget(path: AppAssets.b1),
          ImageWidget(path: AppAssets.b2),
          ImageWidget(path: AppAssets.b3),
        ],
      ),
    );
  }
}
