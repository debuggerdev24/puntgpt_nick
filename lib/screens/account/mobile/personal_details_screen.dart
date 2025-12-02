import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/app_assets.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/utils/field_validators.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';

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
          return Column(
            children: [
              topBar(context, provider),
              //todo form
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
                        style: semiBold(fontSize: (kIsWeb) ? 28.sp : 14.sp),
                      ),
                      6.h.verticalSpace,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: "Enter Your Name",
                        hintStyle: medium(fontSize: (kIsWeb) ? 28.sp : 14.sp),
                        validator: (value) =>
                            FieldValidators().name(value, "Name"),
                      ),
                      //todo --------------> email
                      14.h.verticalSpace,
                      Text(
                        "Email",
                        style: semiBold(fontSize: (kIsWeb) ? 28.sp : 14.sp),
                      ),
                      6.h.verticalSpace,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: "Enter Your Email",
                        hintStyle: medium(fontSize: (kIsWeb) ? 28.sp : 14.sp),
                        validator: (value) => FieldValidators().email(value),
                      ),
                      //todo --------------> phone
                      14.h.verticalSpace,
                      Text(
                        "Phone",
                        style: semiBold(fontSize: (kIsWeb) ? 28.sp : 14.sp),
                      ),
                      6.h.verticalSpace,
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: "Enter Your Phone",
                        hintStyle: medium(fontSize: (kIsWeb) ? 28.sp : 14.sp),
                        validator: (value) =>
                            FieldValidators().mobileNumber(value),
                      ),
                      if (provider.isEdit)
                        AppFiledButton(
                          text: "Save Changes",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              provider.setIsEdit = false;
                            }
                          },
                          margin: EdgeInsets.only(top: 170.h), //
                        ),
                      AppOutlinedButton(
                        text: "Change Password",
                        onTap: () {
                          context.pushNamed(AppRoutes.changePassword.name);
                        },
                        margin: EdgeInsets.only(
                          bottom: 25.h,
                          top: (!provider.isEdit) ? 200.h : 8.h,
                        ), //
                      ),
                    ],
                  ),
                ),
              ),
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
                      fontSize: (kIsWeb) ? 40.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Manage your name, email, etc.",
                    style: semiBold(
                      fontSize: (kIsWeb) ? 26.sp : 14.sp,

                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              Spacer(),
              if (!provider.isEdit)
                GestureDetector(
                  onTap: () {
                    provider.setIsEdit = !(provider.isEdit);
                  },
                  child: Row(
                    spacing: (kIsWeb) ? 8 : 2,
                    children: [
                      SvgPicture.asset(
                        AppAssets.edit,
                        width: (kIsWeb) ? 32.w : 16.w,
                      ),
                      Text(
                        "Edit",
                        style: bold(fontSize: (kIsWeb) ? 32.sp : 16.sp),
                      ),
                    ],
                  ),
                )
              else
                TextButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    provider.setIsEdit = !(provider.isEdit);
                  },

                  child: Text(
                    "Cancel",
                    style: bold(fontSize: 16.sp, color: AppColors.primary),
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
