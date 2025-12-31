import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/utils/app_toast.dart';
import 'package:puntgpt_nick/core/utils/custom_loader.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/app_outlined_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/on_button_tap.dart';
import '../../../provider/account/account_provider.dart';

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

    final twentyTwoResponsive = context.isDesktop
        ? 22.sp
        : context.isTablet
        ? 30.sp
        : (kIsWeb)
        ? 38.sp
        : 22.sp;
    double fieldWidth = context.isDesktop ? 320.w : 380.w;
    return Consumer<AccountProvider>(
      builder: (context, provider, child) {
        bool readOnly = (provider.isEdit) ? false : true;
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
                  twelveResponsive: twelveResponsive,
                  sixteenResponsive: sixteenResponsive,
                  responsiveIcon: twentyTwoResponsive,
                ),
              ),
              horizontalDivider(),
              15.w.verticalSpace,

              //todo text fields
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Wrap(
                  spacing: 16.w,
                  runSpacing: 12.h,
                  children: [
                    SizedBox(
                      width: fieldWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5.h,
                        children: [
                          Text(
                            "Name",
                            style: semiBold(fontSize: twelveResponsive),
                          ),
                          AppTextField(
                            controller: provider.nameCtr,
                            hintText: "Enter your Name",

                            readOnly: readOnly,
                            hintStyle: semiBold(
                              color: AppColors.primary.withValues(alpha: 0.7),
                              fontSize: context.isDesktop ? 14.sp : 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: fieldWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5.h,
                        children: [
                          Text(
                            "Email",
                            style: semiBold(fontSize: twelveResponsive),
                          ),
                          AppTextField(
                            readOnly: readOnly,
                            controller: provider.emailCtr,
                            hintText: "Enter your Email",
                            hintStyle: semiBold(
                              color: AppColors.primary.withValues(alpha: 0.7),
                              fontSize: context.isDesktop ? 14.sp : 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: fieldWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5.h,
                        children: [
                          Text(
                            "Phone",
                            style: semiBold(fontSize: twelveResponsive),
                          ),
                          AppTextField(
                            readOnly: readOnly,

                            controller: provider.phoneCtr,
                            hintText: "Enter your Phone Number",
                            hintStyle: semiBold(
                              color: AppColors.primary.withValues(alpha: 0.7),
                              fontSize: context.isDesktop ? 14.sp : 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppOutlinedButton(
                margin: EdgeInsets.only(
                  top: context.isDesktop ? 24.w : 34.w,
                  left: 24.w,
                  right: 24.w,
                ),
                text: "Change Password",
                onTap: () {
                  provider.setIsShowChangePassword =
                      !provider.showChangePassword;
                },
                isExpand: false,
                padding: EdgeInsets.symmetric(
                  vertical: context.isDesktop ? 11.w : 16.w,
                  horizontal: context.isDesktop ? 20.w : 25.w,
                ),
                textStyle: semiBold(fontSize: fourteenResponsive),
              ),
              AppFiledButton(
                margin: EdgeInsets.only(
                  top: context.isDesktop ? 24.w : 34.w,
                  left: 24.w,
                  right: 24.w,
                ),
                text: "Save",
                onTap: () {
                  provider.updateProfile(
                    onSuccess: () {
                      AppToast.success(
                        context: context,
                        message: "Profile updated successfully",
                      );
                    },
                    onNoChanges: () {
                      AppToast.info(
                        context: context,
                        message: "No changes found.",
                      );
                    },
                    onFailed: (error) {
                      AppToast.error(context: context, message: error);
                    },
                  );
                },
                isExpand: false,
                padding: EdgeInsets.symmetric(
                  vertical: context.isDesktop ? 11.w : 16.w,
                  horizontal: context.isDesktop ? 20.w : 25.w,
                ),
                child: (provider.isUpdateProfileLoading)
                    ? webProgressIndicator(context)
                    : null,
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
    required double sixteenResponsive,
    required double responsiveIcon,
    required GlobalKey<FormState> formKey,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Spacer(),
        (provider.isEdit)
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
                  spacing: context.isDesktop ? 5.w : 10.w,
                  children: [
                    SvgPicture.asset(
                      AppAssets.edit,
                      width: context.isDesktop ? 18.w : 22.w,
                    ),
                    Text("Edit", style: bold(fontSize: sixteenResponsive)),
                  ],
                ),
              ),
      ],
    );
  }
}
