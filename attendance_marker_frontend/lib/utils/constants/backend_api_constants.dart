import 'package:flutter_dotenv/flutter_dotenv.dart';

class BackendAPIConstants {
  static String rootAPI = dotenv.env['BACKEND_API'].toString();
  // static String rootAPI = dotenv.env['BACKEND_IP_ADDRESS_API'].toString();
  // static String rootAPI = dotenv.env['BACKEND_IP_ADDRESS_HOME_API'].toString();

  // User API
  static const String loginAPI = '/auth/login';
  static const String registerAPI = '/auth/register';
  static const String logoutAPI = '/auth/log-out';
  static const String getAllUsersAPI = '/users';
  static const String getUserByIdAPI = '/users/';
  static const String forgotPasswordAPI = '/users/forgot-password';
  static const String validateOTPAPI = '/users/validate-otp';
  static const String resetPasswordAPI = '/users/reset-password/';
  static const String updateUserByIdAPI = '/users/';
  static const String deleteUserByIdAPI = '/users/';
  static const String getUsersByCompanyIdAPI = '/users/company-id/';

  // Company API
  static const String addCompanyAPI = '/companies';
  static const String getAllCompaniesAPI = '/companies';
  static const String getCompanyByIdAPI = '/companies/';
  static const String updateCompanyByIdAPI = '/companies/';
  static const String deleteCompanyByIdAPI = '/companies/';

  // Attendances API
  static const String getAllAttendancesAPI = "/attendances";
  static const String addAttendanceAPI = '/attendances';
  static const String getAttendanceByIdAPI = '/attendances/';
  static const String updateAttendanceEndTimeByIdAPI =
      '/attendances/update-end-time/';
  static const String updateAttendanceByIdAPI = '/attendances/';
  static const String deleteAttendanceByIdAPI = '/attendances/';
  static const String getAttendanceByUserIdAndDateAPI =
      '/attendances/user-id-date/';
  static const String getAttendanceByUserIdAPI = '/attendances/user-id/';
}
