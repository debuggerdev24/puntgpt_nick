import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/utils/date_formater.dart';
import 'package:puntgpt_nick/core/utils/field_validators.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field_drop_down.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/provider/auth_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, _) {
        return Form(
          key: formKey,
          child: Responsive.isMobile(context)
              ? Column(
                  children: [
                    AppTextField(
                      controller: provider.fistNameCtr,
                      hintText: "First Name",
                      validator: FieldValidators().required,
                    ),
                    SizedBox(height: 8),
                    AppTextField(
                      controller: provider.lastNameCtr,
                      hintText: "Last Name",
                      validator: FieldValidators().required,
                    ),
                    SizedBox(height: 8),
                    AppTextField(
                      controller: provider.dobCtr,
                      hintText: "Date of birth",
                      trailingIcon: AppAssets.arrowDown,
                      enabled: false,
                      validator: FieldValidators().required,
                      onTap: () async {
                        final DateTime today = DateTime.now();
                        final DateTime lastDate = DateTime(
                          today.year - 18,
                          today.month,
                          today.day,
                        );
                        final DateTime firstDate = DateTime(1900);
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          firstDate: firstDate,
                          lastDate: lastDate,
                        );
                        LogHelper.info("selected date: $selectedDate");
                        if (selectedDate != null) {
                          provider.dobCtr.text = DateFormatter.formatDateShort(
                            selectedDate,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    AppTextFieldDropdown(
                      items: List.generate(20, (index) => "State ${index + 1}"),
                      hintText: 'State',
                      onChange: (value) => provider.selectedState = value,
                      selectedValue: provider.selectedState,
                      validator: FieldValidators().required,
                    ),
                    SizedBox(height: 8),
                    AppTextField(
                      controller: provider.emailCtr,
                      hintText: "Email",
                      validator: FieldValidators().email,
                    ),
                    SizedBox(height: 8),
                    AppTextField(
                      controller: provider.phoneCtr,
                      hintText: "Phone",
                      validator: FieldValidators().mobileNumber,
                    ),
                    SizedBox(height: 8),
                    AppTextField(
                      controller: provider.passwordCtr,
                      hintText: "Password",
                      obscureText: provider.showSignUpPass,
                      validator: FieldValidators().password,
                      trailingIcon: provider.showSignUpPass
                          ? AppAssets.hide
                          : AppAssets.show,
                      onTrailingIconTap: () =>
                          provider.showSignUpPass = !provider.showSignUpPass,
                    ),
                  ],
                )
              : SizedBox(
                  width: context.screenWidth * 0.8.flexClamp(null, 800),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: provider.fistNameCtr,
                              hintText: "First Name",
                              validator: FieldValidators().required,
                            ),
                          ),
                          SizedBox(width: 24.w.flexClamp(20, 24)),
                          Expanded(
                            child: AppTextField(
                              controller: provider.lastNameCtr,
                              hintText: "Last Name",
                              validator: FieldValidators().required,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: TextEditingController(),
                              hintText: "Date of birth",
                              trailingIcon: AppAssets.arrowDown,
                              validator: (value) => FieldValidators()
                                  .dateValidator(DateTime.parse(value ?? "")),
                            ),
                          ),
                          SizedBox(width: 24.w.flexClamp(20, 24)),
                          Expanded(
                            child: AppTextField(
                              controller: TextEditingController(),
                              hintText: "State",
                              trailingIcon: AppAssets.arrowDown,
                              validator: FieldValidators().required,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: provider.emailCtr,
                              hintText: "Email",
                              validator: FieldValidators().email,
                            ),
                          ),
                          SizedBox(width: 24.w.flexClamp(20, 24)),
                          Expanded(
                            child: AppTextField(
                              controller: provider.phoneCtr,
                              hintText: "Phone",
                              validator: FieldValidators().mobileNumber,
                            ),
                          ),
                        ],
                      ),
                      AppTextField(
                        controller: provider.passwordCtr,
                        hintText: "Password",
                        obscureText: provider.showSignUpPass,
                        validator: FieldValidators().password,
                        trailingIcon: provider.showSignUpPass
                            ? AppAssets.hide
                            : AppAssets.show,
                        onTrailingIconTap: () =>
                            provider.showSignUpPass = !provider.showSignUpPass,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
