class BackendAPIConstants {
  static const String rootAPI = 'http://10.0.2.2:8080/api';
  // static const String rootAPI = 'http://192.168.1.38:8080/api';

  // User API
  static const String loginAPI = '/auth/login';
  static const String registerAPI = '/auth/register';
  static const String getAllUsersAPI = '/test/users';
  static const String getUserByIdAPI = '/test/users/';
  static const String forgotPasswordAPI = '/test/users/forgot-password';
  static const String validateOTPAPI = '/test/users/validate-otp';
  static const String resetPasswordAPI = '/test/users/reset-password';
  static const String updateUserByIdAPI = '/test/users/';
  static const String deleteUserByIdAPI = '/test/users/';

  // Company API
  static const String addCompanyAPI = '/test/companies';
  static const String getAllCompaniesAPI = '/test/companies';
  static const String getCompanyByIdAPI = '/test/companies/';
  static const String updateCompanyByIdAPI = '/test/companies/';
  static const String deleteCompanyByIdAPI = '/test/companies/';

  // Attendances API
  static const String getAllAttendancesAPI = "/test/attendances";
  static const String addAttendanceAPI = '/test/attendances';
  static const String getAttendanceByIdAPI = '/test/attendances/';
  static const String updateAttendanceEndTimeByIdAPI = '/test/attendances/update-end-time/';
  static const String updateAttendanceByIdAPI = '/test/attendances/';
  static const String deleteAttendanceByIdAPI = '/test/attendances/';
  static const String getAttendanceByUserIdAndDateAPI = '/test/attendances/by-user-id/';
}
