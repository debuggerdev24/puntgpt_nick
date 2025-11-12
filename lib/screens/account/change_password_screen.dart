import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_style.dart';
import '../../core/widgets/app_devider.dart';
import '../../core/widgets/app_text_field.dart';
import '../../provider/account_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        children: [
          topBar(context),
          28.h.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Consumer<AccountProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //todo ------------> Current Password
                        Text("Current Password", style: semiBold(fontSize: 14)),
                        6.h.verticalSpace,
                        AppTextField(
                          controller: _currentPassword,
                          obscureText: provider.currentPassObscure,
                          hintText: "Enter Current Password",

                          trailingIcon: provider.confirmPassObscure
                              ? AppAssets.hide
                              : AppAssets.show,

                          onTrailingIconTap: () {
                            provider.confirmPassObscure =
                                !provider.confirmPassObscure;
                          },
                        ),

                        //todo ------------> New Password
                        14.h.verticalSpace,
                        Text("New Password", style: semiBold(fontSize: 14)),
                        6.h.verticalSpace,
                        AppTextField(
                          controller: _newPassword,
                          obscureText: provider.newPassObscure,
                          hintText: "Enter New Password",
                          trailingIcon: provider.confirmPassObscure
                              ? AppAssets.hide
                              : AppAssets.show,

                          onTrailingIconTap: () {
                            provider.confirmPassObscure =
                                !provider.confirmPassObscure;
                          },
                        ),

                        //todo ------------> Confirm Password
                        14.h.verticalSpace,
                        Text("Confirm Password", style: semiBold(fontSize: 14)),
                        6.h.verticalSpace,
                        AppTextField(
                          controller: _confirmPassword,
                          obscureText: provider.confirmPassObscure,
                          hintText: "Re-enter New Password",
                          trailingIcon: provider.confirmPassObscure
                              ? AppAssets.hide
                              : AppAssets.show,

                          onTrailingIconTap: () {
                            provider.confirmPassObscure =
                                !provider.confirmPassObscure;
                          },
                        ),

                        AppFiledButton(
                          text: "Save",
                          onTap: () {
                            // Validate and save password
                            if (_currentPassword.text.isEmpty ||
                                _newPassword.text.isEmpty ||
                                _confirmPassword.text.isEmpty) {
                              // Show error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please fill all fields'),
                                ),
                              );
                              return;
                            }

                            if (_newPassword.text != _confirmPassword.text) {
                              // Show error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Passwords do not match'),
                                ),
                              );
                              return;
                            }

                            // Save password logic here
                            context.pop();
                          },
                          margin: EdgeInsets.only(bottom: 30.h, top: 210.h),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
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
                      fontSize: 24,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Change Password for your account.",
                    style: semiBold(
                      fontSize: 14,
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
