import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController fistNameCtr = TextEditingController();
  TextEditingController lastNameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController dobCtr = TextEditingController();

  TextEditingController loginEmailCtr = TextEditingController();
  TextEditingController loginPasswordCtr = TextEditingController();

  String? _selectedState;
  String? get selectedState => _selectedState;
  set selectedState(String? value) {
    _selectedState = value;
    notifyListeners();
  }

  bool _showSignUoPass = false;
  bool get showSignUpPass => _showSignUoPass;
  set showSignUpPass(bool value) {
    _showSignUoPass = value;
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

  void clearSignUpControllers() {
    fistNameCtr.clear();
    lastNameCtr.clear();
    emailCtr.clear();
    phoneCtr.clear();
    passwordCtr.clear();
    dobCtr.clear();
  }

  void clearLoginControllers() {
    loginEmailCtr.clear();
    loginPasswordCtr.clear();
  }
}
