import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/utils/app_toast.dart';
import 'package:puntgpt_nick/service/auth/auth_api_service.dart';

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
  bool get showConfirmPass => _showSignUpPass;
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

  bool isSignUpLoading = false;
  Future<void> registerUser({
    required BuildContext context,
    required bool isFreeSignUp,
  }) async {
    isSignUpLoading = true;
    notifyListeners();
    final result = await UserAuthService.instance.registerUser(
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
        AppToast.error(context: context, message: l.apiErrorMsg!);
      },
      (r) {
        final data = r["data"];
        AppToast.success(context: context, message: "Register Successfully.");
        context.pushNamed(
          AppRoutes.loginScreen.name,
          extra: {"is_free_sign_up": isFreeSignUp},
        );
      },
    );
    isSignUpLoading = false;
    notifyListeners();
  }

  void clearSignUpControllers() {
    firstNameCtr.clear();
    lastNameCtr.clear();
    emailCtr.clear();
    phoneCtr.clear();
    passwordCtr.clear();
    dobCtr.clear();
    _isReadTermsAndConditions = false;
  }

  void clearLoginControllers() {
    loginEmailCtr.clear();
    loginPasswordCtr.clear();
  }
}
