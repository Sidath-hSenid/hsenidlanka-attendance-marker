class ModelConstants {
  // User Model
  static const String userId = "id";
  static const String username = "username";
  static const String email = "email";
  static const String password = "password";
  static const String companyModel = "company";
  static const String token = "token";
  static const String user = "user";
  static const String userRoles = "roles";
  static const String userRole = "user";
  static const List<dynamic> authRole = ["ROLE_USER"];

  // Company Model
  static const String companyId = "id";
  static const String companyName = "companyName";
  static const String companyLocation = "companyLocation";
  static const String company = "company";

  // Attendance Model
  static const String attendanceId = "id";
  static const String date = "date";
  static const String startTime = "startTime";
  static const String endTime = "endTime";
  static const String workedHours = "workedHours";
  static const String userModel = "user";
  static const String halfDay = "halfDay";
  static const bool halfDayFlaseBool = false;
  static const bool halfDayTrueBool = true;
  static const String halfDayFlase = "false";
  static const String halfDayTrue = "true";

  // Serivce Values
  static const String auth = "Authorization";
  static const String addParams = "/";
  static const double halfDayTime = 4;
  static const double fullDayTime = 9;
  static const double overWorkedDayTime = 15;

  // Shared Preferences
  static const String sharedAttendanceId = "attendanceId";
  static const String sharedCompanyId = "companyId";
  static const String sharedUserId = "userId";

  // API responses
  static const String apiStatusCode = "statusCode";
  static const String apiJwtResponse = "jwtResponse";
  static const String apiAttendanceRequest = "attendanceRequest";
  static const String apiCompanyRequest = "companyRequest";
  static const String apiUserRequest = "userRequest";
  static const String apiLoginRequest = "loginRequest";
  static const String apiRegisterRequest = "registerRequest";
  static const String apiAttendanceUpdateEndTimeRequest =
      "attendanceUpdateEndTimeRequest";
  static const String apiAttendanceUpdateRequestById =
      "attendanceUpdateRequestById";
  static const String apiAttendanceResponse = "attendanceResponse";
  static const String apiAttendanceResponseList = "attendanceResponseList";
  static const String apiCompanyResponse = "companyResponse";
  static const String apiCompanyResponseList = "companyResponseList";
  static const String apiUserResponse = "userResponse";
  static const String apiUserResponseList = "userResponseList";
  static const String apiMessage = "message";
}
