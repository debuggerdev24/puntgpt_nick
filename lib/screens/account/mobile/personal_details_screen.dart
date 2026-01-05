import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/app_assets.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/utils/app_toast.dart';
import 'package:puntgpt_nick/core/utils/custom_loader.dart';
import 'package:puntgpt_nick/core/utils/de_bouncing.dart';
import 'package:puntgpt_nick/core/utils/field_validators.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<AccountProvider>(
        builder: (context, provider, child) {
          bool readOnly = (provider.isEdit) ? false : true;
          return Stack(
            children: [
              //todo screen
              Column(
                children: [
                  //todo top bar
                  topBar(context, provider),
                  //todo personal details
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 25.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          28.h.verticalSpace,
                          //todo --------------> name
                          Text(
                            "Name",
                            style: semiBold(
                              fontSize: (context.isBrowserMobile)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.h.verticalSpace,
                          AppTextField(
                            controller: provider.nameCtr,
                            hintText: "Enter Your Name",
                            textStyle: medium(
                              fontSize: (context.isBrowserMobile)
                                  ? 32.sp
                                  : 16.sp,
                            ),
                            readOnly: readOnly,
                            hintStyle: medium(
                              fontSize: (context.isBrowserMobile)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                            validator: (value) =>
                                FieldValidators().name(value, "Name"),
                          ),
                          //todo --------------> email
                          14.h.verticalSpace,
                          Text(
                            "Email",
                            style: semiBold(
                              fontSize: (context.isBrowserMobile)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.h.verticalSpace,
                          AppTextField(
                            controller: provider.emailCtr,
                            hintText: "Enter Your Email",
                            textStyle: medium(
                              fontSize: (context.isBrowserMobile)
                                  ? 32.sp
                                  : 16.sp,
                            ),
                            readOnly: readOnly,
                            hintStyle: medium(
                              fontSize: (context.isBrowserMobile)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                            validator: (value) =>
                                FieldValidators().email(value),
                          ),
                          //todo --------------> phone
                          14.h.verticalSpace,
                          Text(
                            "Phone",
                            style: semiBold(
                              fontSize: (context.isBrowserMobile)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.h.verticalSpace,
                          AppTextField(
                            controller: provider.phoneCtr,
                            hintText: "Enter Your Phone",
                            readOnly: readOnly,
                            textStyle: medium(
                              fontSize: (context.isBrowserMobile)
                                  ? 32.sp
                                  : 16.sp,
                            ),
                            hintStyle: medium(
                              fontSize: (context.isBrowserMobile)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                            validator: (value) =>
                                FieldValidators().mobileNumber(value),
                          ),
                          // Spacer(),
                          if (provider.isEdit)
                            AppFiledButton(
                              text: "Save Changes",
                              textStyle: semiBold(
                                fontSize: (context.isBrowserMobile)
                                    ? 28.sp
                                    : 18.sp,
                                color: AppColors.white,
                              ),

                              onTap: () {
                                deBouncer.run(() {
                                  if (_formKey.currentState!.validate()) {
                                    provider.updateProfile(
                                      onSuccess: () {
                                        AppToast.success(
                                          context: context,
                                          message:
                                              "Profile updated successfully.",
                                        );
                                      },
                                      onFailed: (error) {
                                        AppToast.success(
                                          context: context,
                                          message: error,
                                        );
                                      },
                                      onNoChanges: () {
                                        AppToast.info(
                                          context: context,
                                          message: "No changes found.",
                                        );
                                      },
                                    );
                                    provider.setIsEdit = false;
                                  }
                                });
                              },
                              margin: EdgeInsets.only(top: 190.h),
                            ),

                          AppOutlinedButton(
                            text: "Change Password",
                            onTap: () {
                              context.pushNamed(AppRoutes.changePassword.name);
                            },

                            textStyle: semiBold(
                              fontSize: (context.isBrowserMobile)
                                  ? 28.sp
                                  : 18.sp,
                            ),
                            margin: EdgeInsets.only(
                              bottom: 22.h,
                              top: (!provider.isEdit) ? 220.h : 8.h,
                            ), //
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //todo progress indicator
              if (provider.isUpdateProfileLoading) FullPageIndicator(),
            ],
          );
        },
      ),
    );
  }

  Widget topBar(BuildContext context, AccountProvider provider) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            5.w,
            12.h,
            (!provider.isEdit) ? 25.w : 8.w,
            16.h,
          ),
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
                    "Personal Details",
                    style: regular(
                      fontSize: (context.isBrowserMobile) ? 40.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Manage your name, email, etc.",
                    style: semiBold(
                      fontSize: (context.isBrowserMobile) ? 26.sp : 14.sp,

                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              Spacer(),
              if (provider.isEdit)
                TextButton(
                  onPressed: () {
                    _formKey.currentState?.reset();

                    provider.setIsEdit = !(provider.isEdit);
                  },

                  child: Text(
                    "Cancel",
                    style: bold(
                      fontSize: (context.isBrowserMobile) ? 32.sp : 16.sp,
                      color: AppColors.primary,
                    ),
                  ),
                )
              else
                OnMouseTap(
                  child: GestureDetector(
                    onTap: () {
                      provider.setIsEdit = !(provider.isEdit);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      spacing: (context.isBrowserMobile) ? 8 : 6.w,
                      children: [
                        SvgPicture.asset(
                          AppAssets.edit,
                          width: (context.isBrowserMobile) ? 32.w : 16.w,
                        ),
                        Text(
                          "Edit",
                          style: bold(
                            fontSize: (context.isBrowserMobile) ? 32.sp : 17.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}
