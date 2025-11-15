import 'package:flutter/cupertino.dart';

class AccountProvider extends ChangeNotifier {
  bool _currentPassObscure = true,
      _newPassObscure = true,
      _confirmPassObscure = true,
      _isEdit = false;

  bool get currentPassObscure => _currentPassObscure;
  bool get newPassObscure => _newPassObscure;
  bool get confirmPassObscure => _confirmPassObscure;
  bool get isEdit => _isEdit;

  set setIsEdit(bool value) {
    _isEdit = value;
    notifyListeners();
  }

  void resetPasswordVisibility() {
    _currentPassObscure = true;
    _newPassObscure = true;
    _confirmPassObscure = true;
    notifyListeners();
  }

  set currentPassObscure(bool value) {
    _currentPassObscure = value;
    notifyListeners();
  }

  set newPassObscure(bool value) {
    _newPassObscure = value;
    notifyListeners();
  }

  set confirmPassObscure(bool value) {
    _confirmPassObscure = value;
    notifyListeners();
  }
}
