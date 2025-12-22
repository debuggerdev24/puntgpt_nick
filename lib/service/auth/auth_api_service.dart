import 'package:dartz/dartz.dart';

import '../../core/constants/end_points.dart';
import '../../core/helper/base_api_helper.dart';

class UserAuthService {
  UserAuthService._();

  static final UserAuthService _instance = UserAuthService._();
  static UserAuthService instance = _instance;

  Future<Either<ApiException, Map<String, dynamic>>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await BaseApiHelper.instance.post(
      EndPoints.userLogin,
      data: {"email": email, "password": password},
    );
  }

  Future<Either<ApiException, Map<String, dynamic>>> registerUser({
    required String firstName,
    required String lastName,
    required String dob,
    required String state,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String agreedToTerms,
  }) async {
    return await BaseApiHelper.instance.post<Map<String, dynamic>>(
      EndPoints.userRegister,
      data: {
        "first_name": "Meera",
        "last_name": "Joseph",
        "date_of_birth": "2002-02-06",
        "state": "Kerala",
        "email": "tester@gmail.com",
        "phone": "123456789",
        "password": "Meera@123",
        "confirm_password": "Meera@123",
        "agreed_to_terms": "true",
      },
    );
  }
}
