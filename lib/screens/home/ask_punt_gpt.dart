import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/text_style.dart';
import '../../core/widgets/app_devider.dart';

class AskPuntGpt extends StatelessWidget {
  const AskPuntGpt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        topBar(context),
        Expanded(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  userChat(),
                  userChat(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      appDivider(),
                      TextField(

                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: AppColors.greyColor.withValues(alpha: 0.4), // Set your color
                            //
                            //   ),
                            // ),
                          prefix: SizedBox(width: 25.w,),
                          hintText: "Type your message...",
                          hintStyle: medium(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            color: AppColors.greyColor.withValues(alpha: 0.6)
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ],
    );
  }

  Widget userChat() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("@you",style: semiBold(fontSize: 17),),
            Text(
              "12:41 PM",
              style: semiBold(
                fontSize: 14.5,
                color: AppColors.greyColor.withValues(alpha: 0.6)
              ),
            ),
            3.h.verticalSpace,
            Text("mdsndjkjvdjkvbdjkfvbdf c mnbbnxmnfklfjkfjkdm,nnm,nbm,cnvm,bncmnbmcb"),
            16.h.verticalSpace,
            appDivider(),

          ],
        ),
    );
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 12.h),
            child: Row(
              spacing: 14.w,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ask @PuntGPT",
                      style: regular(
                        fontFamily: AppFontFamily.secondary,
                        height: 1.35,
                      ),
                    ),
                    Text(
                      "Chat with AI",
                      style: medium(
                        fontSize: 14.sp,
                        color: AppColors.greyColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        appDivider(),

      ],
    );
  }

}
