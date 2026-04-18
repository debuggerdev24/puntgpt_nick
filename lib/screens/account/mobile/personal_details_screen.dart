import 'package:flutter_svg/flutter_svg.dart';
import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/screens/auth/auth_constants.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hintStyle = medium(
      fontSize: (context.isMobileWeb) ? 28.sp : 14.sp,
      color: AppColors.primary.withValues(alpha: 0.65),
    );
    return Form(
      key: _formKey,
      child: Consumer<AccountProvider>(
        builder: (context, provider, child) {
          bool readOnly = (provider.isEdit) ? false : true;
          return Stack(
            children: [
              //* screen
              Column(
                children: [
                  //* top bar
                  topBar(context, provider),
                  //* personal details
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 25.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          28.h.verticalSpace,
                          //* --------------> name
                          Text(
                            "Name *",
                            style: semiBold(
                              fontSize: (context.isMobileWeb)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.w.verticalSpace,
                          AppTextField(
                            controller: provider.nameCtr,
                            hintText: "Enter Your Name",
                            textInputAction: TextInputAction.next,

                            readOnly: readOnly,
                            hintStyle: hintStyle,
                            validator: (value) =>
                                FieldValidators().name(value, "Name"),
                          ),
                          //* --------------> email
                          14.w.verticalSpace,
                          Text(
                            "Email *",
                            style: semiBold(
                              fontSize: (context.isMobileWeb)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.w.verticalSpace,
                          AppTextField(
                            controller: provider.emailCtr,
                            hintText: "Enter Your Email",
                            textInputAction: TextInputAction.next,
                            readOnly: readOnly,

                            hintStyle: hintStyle,
                            validator: (value) =>
                                FieldValidators().email(value),
                          ),
                          //* --------------> phone
                          14.w.verticalSpace,
                          Text(
                            "Phone (Optional)",
                            style: semiBold(
                              fontSize: (context.isMobileWeb)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.w.verticalSpace,
                          if (readOnly)
                            AppTextField(
                              controller: provider.phoneCtr,
                              hintText: "Enter Phone",
                              readOnly: true,
                              textInputAction: TextInputAction.next,
                            )
                          else
                            PhoneCountryFieldForAccount(
                              provider: provider,
                              readOnly: false,
                            ),
                          //* --------------> address
                          14.w.verticalSpace,
                          Text(
                            "Address Line 1 (Optional)",
                            style: semiBold(
                              fontSize: (context.isMobileWeb)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.h.verticalSpace,
                          AppTextField(
                            controller: provider.addressLine1Ctr,
                            hintText: "Enter Address Line 1",
                            readOnly: readOnly,
                            textInputAction: TextInputAction.next,
                            hintStyle: hintStyle,
                          ),
                          14.w.verticalSpace,
                          Text(
                            "Address Line 2 (Optional)",
                            style: semiBold(
                              fontSize: (context.isMobileWeb)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.h.verticalSpace,
                          AppTextField(
                            controller: provider.addressLine2Ctr,
                            hintText: "Enter Address Line 2",
                            readOnly: readOnly,
                            textInputAction: TextInputAction.next,
                            hintStyle: hintStyle,
                          ),
                          14.w.verticalSpace,
                          Text(
                            "State (Optional)",
                            style: semiBold(
                              fontSize: (context.isMobileWeb)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.w.verticalSpace,
                          if (readOnly)
                            AppTextField(
                              controller: provider.stateCtr,
                              hintText: "Enter State",
                              readOnly: true,
                              textInputAction: TextInputAction.next,
                            )
                          else
                            AppTextFieldDropdown(
                              items: states,
                              hintText: 'State',
                              selectedValue: provider.stateCtr.text.isEmpty
                                  ? null
                                  : provider.stateCtr.text,
                              onChange: (value) {
                                setState(() {
                                  provider.stateCtr.text = value;
                                });
                              },
                              hintStyle: hintStyle,
                            ),
                          14.w.verticalSpace,
                          Text(
                            "Post Code (Optional)",
                            style: semiBold(
                              fontSize: (context.isMobileWeb)
                                  ? 28.sp
                                  : 14.sp,
                            ),
                          ),
                          6.h.verticalSpace,
                          AppTextField(
                            controller: provider.postCodeCtr,
                            hintText: "Enter Post Code",
                            readOnly: readOnly,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hintStyle: hintStyle,
                          ),

                          if (provider.isEdit)
                            AppFilledButton(
                              text: "Save Changes",
                              textStyle: semiBold(
                                fontSize: (context.isMobileWeb)
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
                              margin: EdgeInsets.only(top: 22.w),
                            ),

                          AppOutlinedButton(
                            text: "Change Password",
                            onTap: () {
                              context.pushNamed(AppRoutes.changePassword.name);
                            },

                            textStyle: semiBold(
                              fontSize: (context.isMobileWeb)
                                  ? 28.sp
                                  : 18.sp,
                            ),
                            margin: EdgeInsets.only(
                              bottom: 16.w,
                              top: 16.w, //220
                            ), //
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //* progress indicator
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
          padding: EdgeInsets.fromLTRB(4.w, 7.w, 25.w, 7.w),

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
                      fontSize: (context.isMobileWeb) ? 40.sp : 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1.11,
                    ),
                  ),
                  Text(
                    "Manage your name, email, etc.",
                    style: semiBold(
                      fontSize: (context.isMobileWeb) ? 26.sp : 14.sp,

                      color: AppColors.primary.withValues(alpha: 0.6),
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
                      fontSize: (context.isMobileWeb) ? 32.sp : 16.sp,
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
                      spacing: (context.isMobileWeb) ? 8 : 6.w,
                      children: [
                        SvgPicture.asset(
                          AppAssets.edit,
                          width: (context.isMobileWeb) ? 32.w : 16.w,
                        ),
                        Text(
                          "Edit",
                          style: bold(
                            fontSize: (context.isMobileWeb) ? 32.sp : 17.sp,
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
