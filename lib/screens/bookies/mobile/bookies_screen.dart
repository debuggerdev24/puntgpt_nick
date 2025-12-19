import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';

class BookiesScreen extends StatelessWidget {
  const BookiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          32.h.verticalSpace,
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
        ],
      ),
    );
  }
}
