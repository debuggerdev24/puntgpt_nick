import 'package:flutter/cupertino.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/models/account/profile_model.dart';
import 'package:puntgpt_nick/service/account/account_api_service.dart';

class AccountProvider extends ChangeNotifier {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();

  late ProfileModel profile;
  bool _currentPassObscure = true,
      _newPassObscure = true,
      _confirmPassObscure = true,
      _isEdit = false;

  int _selectedTab = 0;
  int get selectedAccountTabWeb => _selectedTab;

  set setAccountTabIndex(int index) {
    _selectedTab = index;
    notifyListeners();
  }

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

  Future<void> getProfile() async {
    final result = await AccountApiService.instance.getProfile();
    result.fold(
      (l) {
        Logger.info("Error in get profile methode${l.errorMsg}");
      },
      (r) {
        final data = r["data"];
        profile = ProfileModel.fromJson(data);
        nameCtr.text = profile.name;
        emailCtr.text = profile.email;
        phoneCtr.text = profile.phone;
        notifyListeners();
      },
    );
  }
}
