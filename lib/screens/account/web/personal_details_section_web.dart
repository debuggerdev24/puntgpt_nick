import 'package:flutter_svg/svg.dart';
import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';

class PersonalDetailsSectionWeb extends StatelessWidget {
  const PersonalDetailsSectionWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // final sixteenResponsive = context.isDesktop ? 16.sp : 21.5.sp;
    // final twelveResponsive = context.isDesktop ? 12.sp : 20.sp;
    // final fourteenResponsive = context.isDesktop
    //     ? 14.sp
    //     : context.isTablet
    //     ? 22.sp
    //     : (kIsWeb)
    //     ? 26.sp
    //     : 14.sp;

    // final twentyTwoResponsive = context.isDesktop
    //     ? 22.sp
    //     : context.isTablet
    //     ? 30.sp
    //     : context.isBrowserMobile
    //     ? 38.sp
    //     : 22.sp;
    double fieldWidth = context.isDesktop ? 320.w : 380.w;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Consumer<AccountProvider>(
      builder: (context, provider, child) {
        bool readOnly = (provider.isEdit) ? false : true;
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 8, 11, 8),
                  child: topBar(
                    context: context,
                    provider: provider,
                    formKey: formKey,
                    // twelveResponsive: twelveResponsive,
                    // sixteenResponsive: sixteenResponsive,
                    // responsiveIcon: twentyTwoResponsive,
                  ),
                ),
                horizontalDivider(),
                SizedBox(height: 14), // if (context.isDesktop) 17.w.verticalSpace else 28.w.verticalSpace,
                //* text fields
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: formKey,
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: fieldWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text("Name", style: semiBold(fontSize: 14)),
                              AppTextField(
                                controller: provider.nameCtr,
                                hintText: "Enter your Name",
                                validator: (value) =>
                                    FieldValidators().name(value, "Name"),
                                readOnly: readOnly,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text("Email", style: semiBold(fontSize: 14)),
            
                              AppTextField(
                                readOnly: readOnly,
                                controller: provider.emailCtr,
                                validator: FieldValidators().email,
                                hintText: "Enter your Email",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text("Phone", style: semiBold(fontSize: 14)),
                              if (readOnly)
                                AppTextField(
                                  controller: provider.phoneCtr,
                                  hintText: "Enter Phone",
                                  readOnly: true,
                                )
                              else
                                PhoneCountryFieldForAccount(
                                  provider: provider,
                                  readOnly: false,
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text(
                                "Address Line 1",
                                style: semiBold(fontSize: 14),
                              ),
                              AppTextField(
                                controller: provider.addressLine1Ctr,
                                hintText: "Enter Address Line 1",
                                readOnly: readOnly,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text(
                                "Address Line 2",
                                style: semiBold(fontSize: 14),
                              ),
                              AppTextField(
                                controller: provider.addressLine2Ctr,
                                hintText: "Enter Address Line 2",
                                readOnly: readOnly,
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
                              Text("State", style: semiBold(fontSize: 14)),
                              AppTextField(
                                controller: provider.stateCtr,
                                hintText: "Enter State",
                                readOnly: readOnly,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text("Suburb", style: semiBold(fontSize: 14)),
                              AppTextField(
                                controller: provider.suburbCtr,
                                hintText: "Enter Suburb",
                                readOnly: readOnly,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text("Post Code", style: semiBold(fontSize: 14)),
                              AppTextField(
                                controller: provider.postCodeCtr,
                                hintText: "Enter Post Code",
                                readOnly: readOnly,
                                keyboardType: TextInputType.number,
                                inputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return null;
                                  }
                                  final min = FieldValidators().minLength(
                                    value,
                                    3,
                                  );
                                  if (min != null) return min;
                                  return FieldValidators().maxLength(value, 10);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppOutlinedButton(
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 16,
            
                  ),
                  text: "Change Password",
                  onTap: () {
                    provider.setIsShowChangePassword =
                        !provider.showChangePassword;
                  },
                  width: fieldWidth,
                  padding: EdgeInsets.symmetric(
                    vertical: context.isDesktop ? 12.w : 16.w,
                  ),
                  textStyle: semiBold(fontSize: 14),
                ),
                AppFilledButton(
                  margin: EdgeInsets.only(
                    top: 24,
                    left: 16,
                    right: 24,
                  ),
                  width: fieldWidth,
                  text: "Save",
                  onTap: () {
                    deBouncer.run(() {
                      if (formKey.currentState!.validate()) {
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
                      }
                    });
                  },
                  textStyle: semiBold(fontSize: 14, color: AppColors.white),
                  padding: EdgeInsets.symmetric(
                    vertical: context.isDesktop ? 12.w : 16.5.w,
                  ),
                  child: (provider.isUpdateProfileLoading)
                      ? webProgressIndicator(context)
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget topBar({
    required BuildContext context,
    required AccountProvider provider,
    // required double twelveResponsive,
    // required double sixteenResponsive,
    // required double responsiveIcon,
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
                fontSize: 22, //context.isDesktop ? 24.sp : 30.sp,
                fontFamily: AppFontFamily.secondary,
                height: 1.1,
              ),
            ),
            Text(
              "Manage your name, email, etc.",
              style: semiBold(
                fontSize: 12,
                color: AppColors.primary.withValues(alpha: 0.6),
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
                  style: bold(fontSize: 14, color: AppColors.primary),
                ),
              )
            : OnMouseTap(
                onTap: () {
                  provider.setIsEdit = !(provider.isEdit);
                },

                child: Row(
                  spacing: 5, //context.isDesktop ? 5.w : 10.w,
                  children: [
                    SvgPicture.asset(
                      AppAssets.edit,
                      width: 14, //context.isDesktop ? 18.w : 22.w,
                    ),
                    Text("Edit", style: bold(fontSize: 14)),
                  ],
                ),
              ),
      ],
    );
  }
}
