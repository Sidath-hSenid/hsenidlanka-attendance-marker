class BackendAPI {
  static const String rootAPI = 'http://10.0.2.2:8080/api';

  // User API
  static const String loginAPI = '/auth/login';
  static const String registerAPI = '/auth/register';
  static const String usersAllAPI = '/test/users';
  static const String usersAPI = '/test/users/';
  static const String forgotPasswordAPI = '/test/users/forgot-password';
  static const String validateOTPAPI = '/test/users/validate-otp';
  static const String resetPasswordAPI = '/test/users/reset-password';

  // Company API
  static const String addCompanyAPI = '/test/companies';

}
