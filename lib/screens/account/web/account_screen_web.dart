import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/account/web/personal_details_screen_web.dart';

class AccountScreenWeb extends StatelessWidget {
  const AccountScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final twentyResponsive = context.isDesktop
        ? 20.sp
        : context.isTablet
        ? 28.sp
        : (kIsWeb)
        ? 36.sp
        : 20.sp;
    final sixteenResponsive = context.isDesktop
        ? 16.sp
        : context.isTablet
        ? 24.sp
        : (kIsWeb)
        ? 32.sp
        : 16.sp;
    final eighteenResponsive = context.isDesktop
        ? 18.sp
        : context.isTablet
        ? 26.sp
        : (kIsWeb)
        ? 34.sp
        : 16.sp;
    final fourteenResponsive = context.isDesktop
        ? 14.sp
        : context.isTablet
        ? 22.sp
        : (kIsWeb)
        ? 26.sp
        : 14.sp;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 212.w),
        child: Row(
          children: [
            //todo ---------------> left panel
            verticalDivider(),
            SizedBox(
              width: 312.w,//
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 26.w,
                      vertical: 26.h,
                    ),
                    child: Text(
                      "My Account",
                      style: regular(fontSize: twentyResponsive,fontFamily: AppFontFamily.secondary),
                    ),
                  ),
                  4.h.verticalSpace,
                  //todo 1st tab
                  accountTabs(title: "Personal Details", fourteenResponsive: fourteenResponsive,color: AppColors.primary,onTap: () {
                  },),
                  accountTabs(title: "Manage Subscription", fourteenResponsive: fourteenResponsive,onTap: () {
                  },),
                  horizontalDivider()
                ],
              ),
            ),
            verticalDivider(),
            //todo ----------------> right panel


            verticalDivider(),


          ],
        ),
      ),
    );
  }


  Widget accountTabs({required String title,required double fourteenResponsive,Color? color,required VoidCallback onTap}){
   return OnMouseTap(
     onTap: onTap,
     child: Container(
        color: color,
        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: bold(fontSize: fourteenResponsive,color: color == AppColors.primary ? AppColors.white : null),),
            Icon(Icons.arrow_forward_ios,size: fourteenResponsive-2,color: color == AppColors.primary ? AppColors.white : null)
          ],
        ),
      ),
   );
  }

}
