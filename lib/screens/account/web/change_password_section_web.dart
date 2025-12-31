import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/utils/app_toast.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/utils/custom_loader.dart';
import '../../../core/utils/field_validators.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../provider/account/account_provider.dart';

class ChangePasswordSectionWeb extends StatefulWidget {
  const ChangePasswordSectionWeb({super.key});

  @override
  State<ChangePasswordSectionWeb> createState() =>
      _ChangePasswordSectionWebState();
}

class _ChangePasswordSectionWebState extends State<ChangePasswordSectionWeb> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  formKey: _formKey,
                  twelveResponsive: twelveResponsive,
                  sixteenResponsive: sixteenResponsive,
                  responsiveIcon: twentyTwoResponsive,
                ),
              ),
              horizontalDivider(),
              15.w.verticalSpace,
              //todo text fields
              Form(
                key: _formKey,
                child: Padding(
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
                              "Current Password",
                              style: semiBold(fontSize: twelveResponsive),
                            ),
                            AppTextField(
                              controller: provider.currentPassCtr,
                              hintText: "Enter Current Password",
                              validator: (value) =>
                                  FieldValidators().password(value),

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
                              "New Password",
                              style: semiBold(fontSize: twelveResponsive),
                            ),
                            AppTextField(
                              controller: provider.newPassCtr,
                              hintText: "Enter New Password",
                              validator: (value) =>
                                  FieldValidators().password(value),

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
                              "Confirm Password",
                              style: semiBold(fontSize: twelveResponsive),
                            ),
                            AppTextField(
                              controller: provider.confirmPassCtr,
                              hintText: "Enter Confirm Password",
                              validator: (value) => FieldValidators().match(
                                value,
                                provider.newPassCtr.text.trim(),
                                "Confirm Password should match with a new Password",
                              ),
                              hintStyle: semiBold(
                                color: AppColors.primary.withValues(alpha: 0.7),
                                fontSize: context.isDesktop ? 14.sp : 20.sp,
                              ),

                              onSubmit: () {
                                provider.updatePassword(
                                  onSuccess: () {
                                    AppToast.success(
                                      context: context,
                                      message: "Password updated successfully",
                                    );
                                  },
                                  onError: (error) {
                                    AppToast.error(
                                      context: context,
                                      message: "Failed to update password",
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppFiledButton(
                text: "Save",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    provider.updatePassword(
                      onSuccess: () {
                        AppToast.success(
                          context: context,
                          message: "Password updated successfully",
                        );
                      },
                      onError: (error) {
                        AppToast.error(
                          context: context,
                          message: "Failed to update password",
                        );
                      },
                    );
                  }
                },
                isExpand: false,
                margin: EdgeInsets.only(
                  top: context.isDesktop ? 24.w : 34.w,
                  left: 24.w,
                  right: 24.w,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: context.isDesktop ? 11.w : 16.w,
                  horizontal: context.isDesktop ? 20.w : 25.w,
                ),
                child: (provider.isUpdatePasswordLoading)
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
        OnMouseTap(
          onTap: () {
            provider.setIsShowChangePassword = !provider.showChangePassword;
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: responsiveIcon,
            color: AppColors.primary,
          ),
        ),
        12.w.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change Password",
              style: regular(
                fontSize: context.isDesktop ? 24.sp : 30.sp,
                fontFamily: AppFontFamily.secondary,
                height: 1.4,
              ),
            ),
            Text(
              "Manage Your Password.",
              style: semiBold(
                fontSize: twelveResponsive,
                color: AppColors.greyColor.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        // Spacer(),
        // (provider.isEdit)
        //     ? TextButton(
        //         onPressed: () {
        //           formKey.currentState?.reset();
        //           provider.setIsEdit = !(provider.isEdit);
        //         },
        //
        //         child: Text(
        //           "Cancel",
        //           style: bold(fontSize: 16.sp, color: AppColors.primary),
        //         ),
        //       )
        //     : OnMouseTap(
        //         onTap: () {
        //           provider.setIsEdit = !(provider.isEdit);
        //         },
        //
        //         child: Row(
        //           spacing: context.isDesktop ? 5.w : 10.w,
        //           children: [
        //             SvgPicture.asset(
        //               AppAssets.edit,
        //               width: context.isDesktop ? 18.w : 22.w,
        //             ),
        //             Text("Edit", style: bold(fontSize: sixteenResponsive)),
        //           ],
        //         ),
        //       ),
      ],
    );
  }
}
