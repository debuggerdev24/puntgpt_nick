import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/account/web/personal_details_screen_web.dart';
import 'package:puntgpt_nick/screens/home/web/home_screen_web.dart';

import '../../../core/constants/app_assets.dart';

class AccountScreenWeb extends StatefulWidget {
  const AccountScreenWeb({super.key});

  @override
  State<AccountScreenWeb> createState() => _AccountScreenWebState();
}

class _AccountScreenWebState extends State<AccountScreenWeb> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.isMobile
        ? 1.4.sw
        : context.isTablet
        ? 1116.w
        : 1040.w;
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
    final twelveResponsive = context.isDesktop
        ? 12.sp
        : context.isTablet
        ? 20.sp
        : (kIsWeb)
        ? 28.sp
        : 12.sp;
    final fourteenResponsive = context.isDesktop
        ? 14.sp
        : context.isTablet
        ? 22.sp
        : (kIsWeb)
        ? 26.sp
        : 14.sp;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: bodyWidth,
                child: Consumer<AccountProvider>(
                  builder: (context, provider, child) {
                    return Row(
                      children: [
                        //todo ---------------> left panel
                        verticalDivider(),
                        SizedBox(
                          width: 312.w,
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
                                  style: regular(
                                    fontSize: twentyResponsive,
                                    fontFamily: AppFontFamily.secondary,
                                  ),
                                ),
                              ),
                              4.h.verticalSpace,
                              //todo 1st tab
                              accountTabs(
                                title: "Personal Details",
                                fourteenResponsive: fourteenResponsive,
                                color: AppColors.primary,
                                onTap: () {},
                              ),
                              accountTabs(
                                title: "Manage Subscription",
                                fourteenResponsive: fourteenResponsive,
                                onTap: () {},
                              ),
                              horizontalDivider(),
                            ],
                          ),
                        ),
                        verticalDivider(),
                        //todo ----------------> right panel
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  24.w,
                                  11.h,
                                  22.w,
                                  11.w,
                                ),
                                child: topBar(context: context, provider: provider),
                              ),
                              horizontalDivider(),
                              24.h.verticalSpace,
                              //todo text fields
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Wrap(
                                  spacing: 16.w,
                                  runSpacing: 12.h,
                                  children: [
                                    SizedBox(
                                      width: 320.w,
            
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 5.h,
                                        children: [
                                          Text(
                                            "Name",
                                            style: semiBold(
                                              fontSize: twelveResponsive,
                                            ),
                                          ),
                                          AppTextField(
                                            controller: TextEditingController(),
                                            hintText: "Enter your Name",
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 5.h,
                                        children: [
                                          Text(
                                            "Email",
                                            style: semiBold(
                                              fontSize: twelveResponsive,
                                            ),
                                          ),
                                          AppTextField(
                                            controller: TextEditingController(),
                                            hintText: "Enter your Email",
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 5.h,
                                        children: [
                                          Text(
                                            "Phone",
                                            style: semiBold(
                                              fontSize: twelveResponsive,
                                            ),
                                          ),
                                          AppTextField(
                                            controller: TextEditingController(),
                                            hintText: "Enter your Phone Number",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: AppOutlinedButton(
                                  margin: EdgeInsets.only(top: 24.w
                                  ),
                                  text: "Change Password",
                                  onTap: () {},
                                  isExpand: false,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 11.w,
                                    horizontal: 20.w,
                                  ),
                                  textStyle: semiBold(fontSize: fourteenResponsive),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalDivider(),
                      ],
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: askPuntGPTButtonWeb(context: context),
            ),
          ],
        ),
      ),
    );
  }

  Widget topBar({
    required BuildContext context,
    required AccountProvider provider,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Details",
              style: regular(
                fontSize: 24.sp,
                fontFamily: AppFontFamily.secondary,
                height: 1.35,
              ),
            ),
            Text(
              "Manage your name, email, etc.",
              style: semiBold(
                fontSize: 14.sp,
                color: AppColors.greyColor.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 14.w),
          child: (provider.isEdit)
              ? TextButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    provider.setIsEdit = !(provider.isEdit);
                  },

                  child: Text(
                    "Cancel",
                    style: bold(fontSize: 16.sp, color: AppColors.primary),
                  ),
                )
              : OnMouseTap(
                  onTap: () {
                    provider.setIsEdit = !(provider.isEdit);
                  },

                  child: Row(
                    spacing: 2,
                    children: [
                      SvgPicture.asset(AppAssets.edit),
                      Text("Edit", style: bold(fontSize: 16.sp)),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget accountTabs({
    required String title,
    required double fourteenResponsive,
    Color? color,
    required VoidCallback onTap,
  }) {
    return OnMouseTap(
      onTap: onTap,
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: bold(
                fontSize: fourteenResponsive,
                color: color == AppColors.primary ? AppColors.white : null,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: fourteenResponsive - 2,
              color: color == AppColors.primary ? AppColors.white : null,
            ),
          ],
        ),
      ),
    );
  }
}
