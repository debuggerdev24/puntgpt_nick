class EndPoints {
  EndPoints._();

  static const String userRegister = "/api/accounts/register/";
  static const String userLogin = "/api/accounts/login/";
  static const String forgotPassword = "/api/accounts/forgot-password/";
  static String verifyToken({required String id}) =>
      "/api/accounts/verify-reset-token/$id/";
  static String resetPassword({required String id}) =>
      "/api/accounts/reset-password/$id/";
  static const String profile = "/api/accounts/profile/";
  static const String updateProfile = "/api/accounts/profile/update/";
  static const String updatePassword = "/api/accounts/change-password/";
  static const String getSubscriptionPlans =
      "/api/subscription/subscription-plan/";
  static const String refreshToken = "/api/accounts/token/refresh/";
}
