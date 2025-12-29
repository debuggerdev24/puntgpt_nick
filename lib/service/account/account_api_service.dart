import 'package:dartz/dartz.dart';

import '../../core/constants/end_points.dart';
import '../../core/helper/base_api_helper.dart';

class AccountApiService {
  AccountApiService._();
  static AccountApiService instance = AccountApiService._();

  Future<Either<ApiException, Map<String, dynamic>>> getProfile() async {
    return await BaseApiHelper.instance.get<Map<String, dynamic>>(
      EndPoints.profile,
    );
  }
}
