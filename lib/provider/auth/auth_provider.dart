import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/utils/app_toast.dart';
import 'package:puntgpt_nick/service/auth/auth_api_service.dart';
import 'package:puntgpt_nick/service/storage/locale_storage_service.dart';

import '../../core/helper/log_helper.dart';
import '../../core/router/app/app_routes.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController firstNameCtr = TextEditingController();
  TextEditingController lastNameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController confirmPasswordCtr = TextEditingController();
  TextEditingController dobCtr = TextEditingController();
  TextEditingController loginEmailCtr = TextEditingController();
  TextEditingController loginPasswordCtr = TextEditingController();
  TextEditingController forgotPasswordCtr = TextEditingController();
  TextEditingController newPasswordCtr = TextEditingController();
  TextEditingController resetConfirmPasswordCtr = TextEditingController();
  TextEditingController otpCtr = TextEditingController();

  int _selectedTab = 0;
  String? _selectedState;

  int get selectedTab => _selectedTab;
  set setSelectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }

  String? get selectedState => _selectedState;
  set selectedState(String? value) {
    _selectedState = value;
    notifyListeners();
  }

  bool _showSignUpPass = false;
  bool get showSignUpPass => _showSignUpPass;
  set showSignUpPass(bool value) {
    _showSignUpPass = value;
    notifyListeners();
  }

  bool _showConfirmPass = false;
  bool get showConfirmPass => _showConfirmPass;
  set showConfirmPass(bool value) {
    _showConfirmPass = value;
    notifyListeners();
  }

  bool _showLoginPass = false;
  bool get showLoginPass => _showLoginPass;
  set showLoginPass(bool value) {
    _showLoginPass = value;
    notifyListeners();
  }

  bool _isReadTermsAndConditions = false;
  bool get isReadTermsAndConditions => _isReadTermsAndConditions;
  set isReadTermsAndConditions(bool value) {
    _isReadTermsAndConditions = value;
    notifyListeners();
  }

  //todo register user

  bool isSignUpLoading = false;
  Future<void> registerUser({
    required BuildContext context,
    required bool isFreeSignUp,
  }) async {
    //todo agreed to terms and conditions or not?

    if (!isReadTermsAndConditions) {
      AppToast.warning(
        context: context,
        message: "Please check the box to agree to the terms and continue.",
      );
      return;
    }

    isSignUpLoading = true;
    notifyListeners();
    final result = await AuthService.instance.registerUser(
      firstName: firstNameCtr.text.trim(),
      lastName: lastNameCtr.text.trim(),
      dob: dobCtr.text.trim(),
      state: selectedState!,
      email: emailCtr.text.trim(),
      phone: phoneCtr.text.trim(),
      password: passwordCtr.text.trim(),
      confirmPassword: confirmPasswordCtr.text.trim(),
      agreedToTerms: isReadTermsAndConditions.toString(),
    );

    result.fold(
      (l) {
        Logger.error(l.apiErrorMsg!);
      },
      (r) {
        final data = r["data"];
        AppToast.success(context: context, message: "Register Successfully.");
        context.pushNamed(
          AppRoutes.loginScreen,
          extra: {"is_free_sign_up": isFreeSignUp},
        );

        clearSignUpControllers();
      },
    );
    isSignUpLoading = false;
    notifyListeners();
  }

  //todo user login
  bool isLoginLoading = false;
  Future<void> loginUser({required BuildContext context}) async {
    isLoginLoading = true;
    notifyListeners();

    final result = await AuthService.instance.loginWithEmailPassword(
      email: loginEmailCtr.text.trim(),
      password: loginPasswordCtr.text.trim(),
    );

    Logger.info(result.toString());

    result.fold(
      (l) {
        Logger.error(l.apiErrorMsg!);
        if (l.errorMsg.contains("Invalid email or password")) {
          AppToast.error(
            context: context,
            message: "Account not found with this email!",
          );
        }
      },
      (r) async {
        final data = r["data"];
        AppToast.success(context: context, message: "Login Successfully.");
        await LocaleStorageService.saveUserToken(data["access"]);
        await LocaleStorageService.saveUserRefreshToken(data["refresh"]);
        await LocaleStorageService.saveUserId(data["user_id"].toString());
        await LocaleStorageService.setIsUserLoggedIn();
        await LocaleStorageService.setLoggedInUserEmail(
          loginEmailCtr.text.trim(),
        );
        await LocaleStorageService.setLoggedInUserPassword(
          loginPasswordCtr.text.trim(),
        );
        context.go(AppRoutes.homeScreen);
      },
    );

    isLoginLoading = false;
    notifyListeners();
  }

  bool isForgotPassLoading = false;
  Future<void> forgotPassword({required BuildContext context}) async {
    isForgotPassLoading = true;
    notifyListeners();

    final result = await AuthService.instance.forgotPassword(
      email: forgotPasswordCtr.text.trim(),
    );

    result.fold(
      (l) {
        Logger.error(l.errorMsg);
      },
      (r) {
        AppToast.success(context: context, message: "OTP sent successfully");
        context.pushNamed(AppRoutes.verifyOTPScreen.name);
      },
    );
    isForgotPassLoading = false;
    notifyListeners();
  }

  bool isVerifyOtpLoading = false;
  Future<void> verifyOtp({required BuildContext context}) async {
    isVerifyOtpLoading = true;
    notifyListeners();

    final result = await AuthService.instance.verifyOTP(
      otp: otpCtr.text.trim(),
    );

    result.fold(
      (l) {
        Logger.error(l.errorMsg);
        if (l.errorMsg.contains("expired")) {
          AppToast.error(context: context, message: "Token has expired");
          return;
        }
        AppToast.error(context: context, message: l.errorMsg);
      },
      (r) {
        AppToast.success(context: context, message: "OTP verify successfully");
        context.pushNamed(AppRoutes.resetPasswordScreen.name);
      },
    );
    isVerifyOtpLoading = false;
    notifyListeners();
  }

  //
  void clearSignUpControllers() {
    firstNameCtr.clear();
    lastNameCtr.clear();
    emailCtr.clear();
    phoneCtr.clear();
    passwordCtr.clear();
    dobCtr.clear();
    confirmPasswordCtr.clear();
    selectedState = "";
    _isReadTermsAndConditions = false;
  }

  void clearLoginControllers() {
    loginEmailCtr.clear();
    loginPasswordCtr.clear();
  }
}
