import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/utils/custom_loader.dart';
import 'package:puntgpt_nick/core/utils/de_bouncing.dart';
import 'package:puntgpt_nick/core/utils/field_validators.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/helper/log_helper.dart';
import '../../../core/utils/app_toast.dart';
import '../../../core/widgets/app_devider.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../provider/account/account_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            Column(
              children: [
                topBar(context),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h),

                    child: Form(
                      key: _formKey,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          28.h.verticalSpace,

                          //todo ------------> Current Password
                          Text(
                            "Current Password",
                            style: semiBold(fontSize: 14.sp),
                          ),
                          6.h.verticalSpace,
                          AppTextField(
                            controller: provider.currentPassCtr,
                            obscureText: provider.currentPassObscure,
                            hintText: "Enter Current Password",
                            trailingIcon: provider.currentPassObscure
                                ? AppAssets.hide
                                : AppAssets.show,
                            onTrailingIconTap: () {
                              provider.currentPassObscure =
                                  !provider.currentPassObscure;
                            },
                            validator: (value) =>
                                FieldValidators().password(value),
                          ),
                          //todo ------------> New Password
                          14.h.verticalSpace,
                          Text(
                            "New Password",
                            style: semiBold(fontSize: 14.sp),
                          ),
                          6.h.verticalSpace,
                          AppTextField(
                            controller: provider.newPassCtr,
                            obscureText: provider.newPassObscure,
                            hintText: "Enter New Password",
                            trailingIcon: provider.newPassObscure
                                ? AppAssets.hide
                                : AppAssets.show,

                            onTrailingIconTap: () {
                              provider.newPassObscure =
                                  !provider.newPassObscure;
                            },
                            validator: (value) =>
                                FieldValidators().password(value),
                          ),

                          //todo ------------> Confirm Password
                          14.h.verticalSpace,
                          Text(
                            "Confirm Password",
                            style: semiBold(fontSize: 14.sp),
                          ),
                          6.h.verticalSpace,
                          AppTextField(
                            controller: provider.confirmPassCtr,
                            obscureText: provider.confirmPassObscure,
                            hintText: "Re-enter New Password",
                            trailingIcon: provider.confirmPassObscure
                                ? AppAssets.hide
                                : AppAssets.show,

                            onTrailingIconTap: () {
                              provider.confirmPassObscure =
                                  !provider.confirmPassObscure;
                            },
                            validator: (value) => FieldValidators().match(
                              value,
                              provider.newPassCtr.text.trim(),
                              "Confirm Password should match with a new Password",
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: AlignmentGeometry.bottomCenter,
                            child: AppFilledButton(
                              text: "Save",
                              onTap: () {
                                deBouncer.run(() {
                                  if (_formKey.currentState!.validate()) {
                                    provider.updatePassword(
                                      onSuccess: () {
                                        AppToast.success(
                                          context: context,
                                          message:
                                              "Password updated successfully.",
                                        );
                                      },
                                      onError: (errorMsg) {
                                        AppToast.error(
                                          context: context,
                                          message: errorMsg,
                                        );
                                        Logger.error(errorMsg);
                                      },
                                    );
                                    return;
                                  }
                                });
                              },
                              margin: EdgeInsets.only(
                                bottom: 25.h,
                              ), // top: 200.h
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            if (provider.isUpdateProfileLoading) FullPageIndicator(),
          ],
        );
      },
    );
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5.w, 12.h, 25.w, 16.h),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,

                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change Password",
                    style: regular(
                      fontSize: 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Change Password for your account.",
                    style: semiBold(
                      fontSize: 14.sp,
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}
