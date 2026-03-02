import 'package:country_picker/country_picker.dart';
import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/provider/auth/auth_provider.dart';

/// Mobile number input with integrated country picker (flag + dropdown inside the field).
/// Uses [AuthProvider.phoneCtr] for national number and [AuthProvider.selectedPhoneCountry] for country.
/// Validates length according to selected country's example.
class PhoneCountryField extends StatelessWidget {
  const PhoneCountryField({
    super.key,
    required this.provider,
    this.hintText = 'Mobile number',
    this.hintStyle,
  });

  final AuthProvider provider;
  final String hintText;
  final TextStyle? hintStyle;

  /// Max digits for the selected country from [Country.example]. Falls back to 15 if unknown.
  static int _maxLengthForCountry(Country country) {
    final example = country.example.toString();
    final digits = example.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.isEmpty ? 15 : digits.length;
  }

  void _openCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        provider.selectedPhoneCountry = country;
        final maxLen = _maxLengthForCountry(country);
        final digits = provider.phoneCtr.text.replaceAll(RegExp(r'[^0-9]'), '');
        if (digits.length > maxLen) {
          provider.phoneCtr.text = digits.substring(0, maxLen);
          provider.phoneCtr.selection =
              TextSelection.collapsed(offset: provider.phoneCtr.text.length);
        }
      },
      countryListTheme: CountryListThemeData(
        flagSize: 24,
        backgroundColor: AppColors.white,
        textStyle: medium(fontSize: 16.sp, color: AppColors.primary),
        inputDecoration: InputDecoration(
          hintText: 'Search country',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.black, width: 1.7),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final country = authProvider.selectedPhoneCountry ?? CountryService().findByCode("au")!;

        return Padding(
          padding: EdgeInsets.only(bottom: 8.w),
          child: FormField<String>(
            validator: (_) => FieldValidators().phoneNumberForCountry(
              authProvider.phoneCtr.text.trim(),
              country,
            ),
            builder: (formState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 6.w,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: formState.hasError
                            ? AppColors.red
                            : AppColors.primary.withValues(alpha: 0.15),
                        width: formState.hasError ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        23.horizontalSpace,

                        // Padding(
                        //   padding: EdgeInsets.only(left: 16.w),
                        //   child: Icon(
                        //     Icons.phone_outlined,
                        //     size: 20.w,
                        //     color: AppColors.primary.withValues(alpha: 0.6),
                        //   ),
                        // ),
                        // SizedBox(width: 10.w),
                          Text(
                            '+${country.phoneCode}',
                            style: medium(
                              fontSize: context.isBrowserMobile ? 28.sp : 16.sp,
                              color: AppColors.primary.withValues(alpha: 0.8),
                            ),
                          ),
                        8.w.horizontalSpace,
                        Expanded(
                          child: TextFormField(
                            controller: authProvider.phoneCtr,
                            keyboardType: TextInputType.phone,
                            maxLength: _maxLengthForCountry(country),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                  _maxLengthForCountry(country)),
                            ],
                            decoration: InputDecoration(
                              hintText: (country.fullExampleWithPlusSign ?? '')
                                      .replaceFirst('+${country.phoneCode}', '')
                                      .trim(),
                              hintStyle: hintStyle ??
                                  medium(
                                    fontSize: context.isBrowserMobile
                                        ? 28.sp
                                        : 14.sp,
                                    color: AppColors.primary.withValues(alpha: 0.5),
                                  ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 16.h,
                              ),
                              isDense: true,
                              counterText: '',
                            ),
                            style: medium(
                              fontSize: context.isBrowserMobile ? 28.sp : 16.sp,
                            ),
                            onChanged: (_) {
                              formState.didChange(authProvider.phoneCtr.text);
                            },
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _openCountryPicker(context),
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(8.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 14.h,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    country.flagEmoji ,
                                    style: TextStyle(fontSize: 22.sp),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 22.w,
                                    color: AppColors.primary.withValues(alpha: 0.7),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //! Error message
                  if (formState.hasError) ...[
                    
                    Padding(
                      padding: EdgeInsets.only(left: 29.w),
                      child: Text(
                        formState.errorText!,
                        style: medium(
                          fontSize: context.isBrowserMobile ? 24.sp : 13.sp,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }
}

/// Same as [PhoneCountryField] but for [AccountProvider] (personal details). Supports [readOnly].
class PhoneCountryFieldForAccount extends StatelessWidget {
  const PhoneCountryFieldForAccount({
    super.key,
    required this.provider,
    this.readOnly = false,
    this.hintText = 'Mobile number',
    this.hintStyle,
  });

  final AccountProvider provider;
  final bool readOnly;
  final String hintText;
  final TextStyle? hintStyle;

  static int _maxLengthForCountry(Country country) {
    final example = country.example.toString();
    final digits = example.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.isEmpty ? 15 : digits.length;
  }

  void _openCountryPicker(BuildContext context) {
    if (readOnly) return;
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        provider.selectedPhoneCountry = country;
        final maxLen = _maxLengthForCountry(country);
        final digits = provider.phoneCtr.text.replaceAll(RegExp(r'[^0-9]'), '');
        if (digits.length > maxLen) {
          provider.phoneCtr.text = digits.substring(0, maxLen);
          provider.phoneCtr.selection =
              TextSelection.collapsed(offset: provider.phoneCtr.text.length);
        }
      },
      countryListTheme: CountryListThemeData(
        flagSize: 24,
        backgroundColor: AppColors.white,
        textStyle: medium(fontSize: 16.sp, color: AppColors.primary),
        inputDecoration: InputDecoration(
          hintText: 'Search country',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.black, width: 1.7),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, accountProvider, _) {
        final country = accountProvider.selectedPhoneCountry ?? CountryService().findByCode('au');

        if (readOnly) {
          final displayPhone = country != null
              ? '+${country.phoneCode} ${accountProvider.phoneCtr.text}'
              : accountProvider.phoneCtr.text;
          return Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  if (country != null) ...[
                    Text(country.flagEmoji, style: TextStyle(fontSize: 22.sp)),
                    SizedBox(width: 8.w),
                  ],
                  Expanded(
                    child: Text(
                      displayPhone.isEmpty ? '—' : displayPhone,
                      style: medium(
                        fontSize: context.isBrowserMobile ? 28.sp : 16.sp,
                        color: AppColors.primary.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final c = country;
        return Padding(
          padding: EdgeInsets.only(bottom: 8.w),
          child: FormField<String>(
            validator: (_) => FieldValidators().phoneNumberForCountry(
              accountProvider.phoneCtr.text.trim(),
              country,
            ),
            builder: (formState) {
              final maxLen = c != null ? _maxLengthForCountry(c) : 15;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 6.w,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: formState.hasError
                            ? AppColors.red
                            : AppColors.primary.withValues(alpha: 0.15),
                        width: formState.hasError ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        23.horizontalSpace,
                        Text(
                          c != null ? '+${c.phoneCode}' : 'Select country',
                          style: medium(
                            fontSize: context.isBrowserMobile ? 28.sp : 16.sp,
                            color: AppColors.primary.withValues(alpha: 0.8),
                          ),
                        ),
                        8.w.horizontalSpace,
                        Expanded(
                          child: TextFormField(
                            controller: accountProvider.phoneCtr,
                            keyboardType: TextInputType.phone,
                            maxLength: maxLen,
                            readOnly: readOnly,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(maxLen),
                            ],
                            decoration: InputDecoration(
                              hintText: c != null
                                  ? (c.fullExampleWithPlusSign ?? '')
                                      .replaceFirst('+${c.phoneCode}', '')
                                      .trim()
                                  : hintText,
                              hintStyle: hintStyle ??
                                  medium(
                                    fontSize: context.isBrowserMobile ? 28.sp : 14.sp,
                                    color: AppColors.primary.withValues(alpha: 0.5),
                                  ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                              isDense: true,
                              counterText: '',
                            ),
                            style: medium(fontSize: context.isBrowserMobile ? 28.sp : 16.sp),
                            onChanged: (_) => formState.didChange(accountProvider.phoneCtr.text),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _openCountryPicker(context),
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(8.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    c?.flagEmoji ?? '🌐',
                                    style: TextStyle(fontSize: 22.sp),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(Icons.keyboard_arrow_down_rounded, size: 22.w,
                                      color: AppColors.primary.withValues(alpha: 0.7)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (formState.hasError)
                    Padding(
                      padding: EdgeInsets.only(left: 29.w),
                      child: Text(
                        formState.errorText!,
                        style: medium(
                          fontSize: context.isBrowserMobile ? 24.sp : 13.sp,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
