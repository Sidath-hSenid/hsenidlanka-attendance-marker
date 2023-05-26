import 'package:flutter_dotenv/flutter_dotenv.dart';

class BackendAPIConstants {
  // static String rootAPI = dotenv.env['BACKEND_API'].toString();
  static String rootAPI = dotenv.env['BACKEND_IP_ADDRESS_API'].toString();

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
  static const String getUsersByCompanyIdAPI = '/test/users/company-id/';

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
  static const String updateAttendanceEndTimeByIdAPI =
      '/test/attendances/update-end-time/';
  static const String updateAttendanceByIdAPI = '/test/attendances/';
  static const String deleteAttendanceByIdAPI = '/test/attendances/';
  static const String getAttendanceByUserIdAndDateAPI =
      '/test/attendances/user-id-date/';
  static const String getAttendanceByUserIdAPI = '/test/attendances/user-id/';
}
