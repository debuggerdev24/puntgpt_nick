import 'dart:math' as math;

import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';
import 'package:puntgpt_nick/screens/auth/auth_constants.dart';

class WebSignUpForm extends StatelessWidget {
  const WebSignUpForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;


  @override
  Widget build(BuildContext context) {
    final double hPad = 25.adaptiveSpacing(context);
    final colGap = SizedBox(height: 20);
    final double rowGap = 16.adaptiveSpacing(context);
    final double maxW = math.min(context.screenWidth - 2 * hPad, 600);

    return Consumer<AuthProvider>(
      builder: (context, provider, _) {

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxW),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: provider.firstNameCtr,
                          hintText: "First Name",
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]'),
                            ),
                          ],
                          validator: (value) =>
                              FieldValidators().required(value, "First Name"),
                        ),
                      ),
                      rowGap.horizontalSpace,
                      Expanded(
                        child: AppTextField(
                          controller: provider.lastNameCtr,
                          hintText: "Last Name",
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]'),
                            ),
                          ],    
                          validator: (value) =>
                              FieldValidators().required(value, "Last Name"),
                        ),
                      ),
                    ],
                  ),
                  colGap,
                  AppTextFieldDropdown(
                    items: states,
                    hintText: 'State',  
                    onChange: (value) => provider.selectedState = value,
                    selectedValue: provider.selectedState,
                    validator: (value) =>
                        FieldValidators().required(value, "State"),
                  ),
                  colGap,
                  AppTextField(
                    controller: provider.addressLine1Ctr,
                    hintText: "Address Line 1 (Optional)",
                  ),
                  colGap,
                  AppTextField(
                    controller: provider.addressLine2Ctr,
                    hintText: "Address Line 2 (Optional)",
                  ),
                  colGap,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: provider.suburbCtr,
                          hintText: "Suburb (Optional)",
                        ),
                      ),
                      rowGap.horizontalSpace,
                      Expanded(
                        child: AppTextField(
                          controller: provider.postCodeCtr,
                          hintText: "Post Code (Optional)",
                          keyboardType: TextInputType.number,
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          validator: (value) {
                            if ((value ?? "").trim().isEmpty) return null;
                            return FieldValidators().lengthValidator(value, 4);
                          },
                        ),
                      ),
                    ],
                  ),
                  colGap,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: provider.emailCtr,
                          hintText: "Email",
                          validator: FieldValidators().email,
                        ),
                      ),
                      rowGap.horizontalSpace,
                      Expanded(
                        child: PhoneCountryField(
                          provider: provider,
                        ),
                      ),
                    ],
                  ),
                  colGap,
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
                    colGap,
                  AppTextField(
                    controller: provider.confirmPasswordCtr,
                    hintText: "Confirm Password",
                    obscureText: provider.showConfirmPass,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (provider.passwordCtr.text.trim() !=
                            provider.confirmPasswordCtr.text.trim()) {
                          return "Confirm Password should match with Original Password!";
                        }
                      }
                      return FieldValidators().required(
                        value,
                        "Confirm Password",
                      );
                    },
                    trailingIcon: provider.showConfirmPass
                        ? AppAssets.hide
                        : AppAssets.show,
                    onTrailingIconTap: () =>
                        provider.showConfirmPass = !provider.showConfirmPass,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
