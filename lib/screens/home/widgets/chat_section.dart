import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';

class ChatSection extends StatelessWidget {
  const ChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("@you", style: semiBold(fontSize: 17)),
          Text(
            "12:41 PM",
            style: semiBold(
              fontSize: 14.5,
              color: AppColors.greyColor.withValues(alpha: 0.6),
            ),
          ),
          3.h.verticalSpace,
          Text(
            "mdsndjkjvdjkvbdjkfvbdf c mnbbnxmnfklfjkfjkdm,nnm,nbm,cnvm,bncmnbmcb",
          ),
          16.h.verticalSpace,
          appDivider(),
        ],
      ),
    );
  }
}
