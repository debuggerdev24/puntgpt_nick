import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_style.dart';
import '../../../../core/widgets/app_devider.dart';
import '../../../../core/widgets/app_outlined_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/on_button_tap.dart';
import '../../../../provider/account/account_provider.dart';

class PersonalDetailsSectionWeb extends StatelessWidget {
  const PersonalDetailsSectionWeb({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
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
    return Consumer<AccountProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.isDesktop ? 24.w : 30.w,
                  vertical: context.isDesktop ? 11.w : 17.w,
                ),
                child: topBar(
                  context: context,
                  provider: provider,
                  formKey: formKey,
                  twelveResponsive: twelveResponsive
                ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5.h,
                        children: [
                          Text(
                            "Name",
                            style: semiBold(fontSize: twelveResponsive),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5.h,
                        children: [
                          Text(
                            "Email",
                            style: semiBold(fontSize: twelveResponsive),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5.h,
                        children: [
                          Text(
                            "Phone",
                            style: semiBold(fontSize: twelveResponsive),
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
                  margin: EdgeInsets.only(top: 24.w),
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
        );
      },
    );
  }

  Widget topBar({
    required BuildContext context,
    required AccountProvider provider,
    required double twelveResponsive,
    required GlobalKey<FormState> formKey,
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
                fontSize: context.isDesktop ? 24.sp : 30.sp,
                fontFamily: AppFontFamily.secondary,
                height: 1.35,
              ),
            ),
            Text(
              "Manage your name, email, etc.",
              style: semiBold(
                fontSize: twelveResponsive,
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
                    formKey.currentState?.reset();
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
}
