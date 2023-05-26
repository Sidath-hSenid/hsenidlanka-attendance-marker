class TextConstants {
  // Application Texts
  static const String appTitle = "ATTENDANCE MARKER";

  // Validation Texts
  static const String emptyValueValidation = "Field can not be empty!";
  static const String emptySelectValidation = 'Please select an option!';
  static const String passwordLengthValidation =
      "Password must contain at least 8 characters!";
  static const String passwordStrengthValidation = "Your password is too week!";
  static const String emailValidation = "Please enter valid email address!";
  static const String otpValidation = "Please enter valid OTP!";
  static const String passwordMisMatchValidation = "Passwords mismatching!";
  static const String startTimeValidation =
      "Start time can not be greater than end time!";
  static const String endTimeValidation =
      "End time can not be less than start time!";

  // User attribute Texts
  static const String userId = "User ID";
  static const String userName = "Username";
  static const String password = "Password";
  static const String email = "Email";
  static const String otp = "OTP";
  static const String newPassword = "New password";
  static const String confirmPassword = "Confirm password";
  static const String selectCompany = "Select a company";
  static const String searchCompany = "Search & select a company";

  // Company attribute Texts
  static const String companyId = "Company ID";
  static const String companyName = "Company Name";
  static const String companyLocation = "Company Location";

  // Attendance attribute Texts
  static const String attendanceId = "Attendance ID";
  static const String attendanceDate = "Date";
  static const String attendanceStartTime = "Start Time";
  static const String attendanceEndTime = "End Time";
  static const String attendanceWorkedHours = "Worked Hours";
  static const String attendanceUsername = "User";
  static const String attendanceCompanyName = "User Company";
  static const String attendanceCompanyLocation = "Company Location";

  // Button Texts
  static const String signInButtonText = "SIGN IN";
  static const String forgotPasswordButtonText = "SEND OTP";
  static const String validateOTPButtonText = "VALIDATE";
  static const String resetPasswordButtonText = "RESET";
  static const String addCompanyButtonText = "ADD";
  static const String updateCompanyButtonText = "UPDATE";
  static const String addUserButtonText = "REGISTER";
  static const String updateUserButtonText = "UPDATE";
  static const String updateAttendanceButtonText = "UPDATE";

  // User Toast Texts
  static const String signInButtonSuccessToast = "Authenticated!";
  static const String signInButtonErrorToast = "Invalid email or password!";
  static const String userServiceLoginErrorToast = "Unable to Sign In!";
  static const String forgotPasswordButtonErrorToast = "Invalid email address!";
  static const String forgotPasswordButtonSuccessToast = "OTP sent to email!";
  static const String userServiceForgotPasswordErrorToast =
      "Unable to send OTP!";
  static const String validateOTPButtonErrorToast = "Invalid otp address!";
  static const String validateOTPButtonSuccessToast = "Validate OTP!";
  static const String userServiceValidateOTPErrorToast = "Unable to validate!";
  static const String resetPasswordButtonErrorToast = "Attepmt unsuccessful!";
  static const String resetPasswordButtonSuccessToast =
      "Password reset successfully!";
  static const String userServiceResetPasswordErrorToast = "Unable to reset!";
  static const String allUserSuccessToast = "Users available!";
  static const String allUserErrorToast = "No users available!";
  static const String singleUserSuccessToast = "User available!";
  static const String singleUserErrorToast = "No user available!";
  static const String updateUserSuccessToast = "User updated successfully!";
  static const String updateUserErrorToast = "Unable to update the user!";
  static const String deleteUserSuccessToast = "User deleted successfully!";
  static const String deleteUserErrorToast = "Unable to delete the user. User may have recoreded attendances!";
  static const String signUpButtonSuccessToast = "User registered!";
  static const String signUpButtonAlreadyErrorToast = "User already exists!";

  // Company Toast Texts
  static const String addCompanyButtonSuccessToast =
      "Company added successfully!";
  static const String companyServiceAddCompanyErrorToast =
      "Unable to add company!";
  static const String addCompanyButtonErrorToast = "Unable to add company!";

  static const String allCompanySuccessToast = "Companies available!";
  static const String allCompanyErrorToast = "No companies available!";
  static const String singleCompanySuccessToast = "Company available!";
  static const String singleCompanyErrorToast = "No company available!";
  static const String updateCompanySuccessToast =
      "Company updated successfully!";
  static const String updateCompanyErrorToast = "Unable to update the company!";
  static const String deleteCompanySuccessToast =
      "Company deleted successfully!";
  static const String deleteCompanyErrorToast = "Unable to delete the company. Company may have registered users!";

  // Attendance Toast Texts
  static const String allAttendanceSuccessToast = "Attendances available!";
  static const String allAttendanceErrorToast = "No attendance available!";
  static const String singleAttendanceSuccessToast = "Attendance available!";
  static const String singleAttendanceErrorToast = "No attendance available!";
  static const String updateAttendanceSuccessToast =
      "Attendance updated successfully!";
  static const String updateAttendanceErrorToast =
      "Unable to update the attendance!";
  static const String addAttendanceSuccessToast =
      "Start time for the day successfully added!";
  static const String addAttendanceErrorToast =
      "Unable to add start time for the day!";
  static const String updateAttendanceEndTimeSuccessToast =
      "End time for the day successfully updated!";
  static const String updateAttendanceEndTimeErrorToast =
      "Unable to update end time for the day!";
  static const String deleteAttendanceSuccessToast =
      "Attendance deleted successfully!";
  static const String deleteAttendanceErrorToast =
      "Unable to delete the attendance!";
  static const String attendanceLocationErrorToast =
      "You are in the wrong location. Unable to add time!";
  static const String alreadyAddedAttendanceErrorToast =
      "Seems like you have already added the start time for today!";
  static const String alreadyUpdatedAttendanceErrorToast =
      "Seems like you have already added the end time for today!";
  static const String notAddedEndTimeAttendanceErrorToast =
      "Seems like you have forgot to add the end time!";
  static const String haveNotAddedAttendanceErrorToast =
      "Seems like you have not add the start time for today!";
  static const String attendanceDateErrorToast =
      "Current date is not equal to your time started date!";
  static const String wrongTimeRangeErrorToast = "Wrong working hours!";
  static const String userAllAttendanceSuccessToast =
      "Slide left to view your previous attendances!";
  static const String addCompanyButtonAlreadyErrorToast =
      "Company already exists or somthing went wrong!";

  // Log Error Texts
  static const String buttonLogError = "Error!";

  // Title Texts
  static const String signInTitleText = "SIGN IN";
  static const String forgotPasswordTitleText = "FORGOT PASSWORD";
  static const String validateOTPTitleText = "VALIDATE OTP";
  static const String resetPasswordTitleText = "RESET PASSWORD";

  // AppBar Title Texts
  static const String allCompaniesAppBarTitleText = "REGISTERED COMPANIES";
  static const String addCompanyAppBarTitleText = "ADD COMPANY";
  static const String detailsCompanyAppBarTitleText = "COMPANY DETAILS";
  static const String allUsersAppBarTitleText = "REGISTERED USERS";
  static const String addUserAppBarTitleText = "ADD USERS";
  static const String detailsUserAppBarTitleText = "USER DETAILS";
  static const String manageCompanyAppBarTitleText = "MANAGE COMPANIES";
  static const String manageUserAppBarTitleText = "MANAGE USERS";
  static const String attendanceSByUserAppBarTitleText = "USER ATTENDANCES";
  static const String usersByCompanyAppBarTitleText = "COMPANY USERS";
  static const String allAttendancesAppBarTitleText = "MARKED ATTENDANCES";
  static const String manageAttendancesAppBarTitleText = "MANAGE ATTENDANCES";
  static const String detailsAttendanceAppBarTitleText = "ATTENDANCE DETAILS";
  static const String detailsAttendancesAppBarTitleText = "USER'S ATTENDANCES";
  static const String detailUsersAppBarTitleText = "COMPANY'S USERS";
  static const String viewUserAttendancesTitleText = "YOUR ATTENDANCES";
  static const String addStartTimeTitleText = "START TIME";
  static const String addEndTimeTitleText = "END TIME";

  // Link Texts
  static const String forgotPasswordLink = "Forgot your password?";
  static const String validateOTPLink = "Reset OTP";

  // Image Link Texts
  static const String appLogoImageLink = "assets/images/app-logo.png";
  static const String addCompanyImageLink = "assets/images/add-company.png";
  static const String companiesImageLink = "assets/images/card-company.png";
  static const String usersImageLink = "assets/images/card-user.png";
  static const String attendancesImageLink = "assets/images/card-attendance.png";
  static const String addUserImageLink = "assets/images/add-user.png";
  static const String fingerPrintImageLink = "assets/images/finger-print.png";
  static const String companiesCardImageLink = "assets/images/card-company.png";
  static const String usersCardImageLink = "assets/images/card-user.png";
  static const String attendacesCardImageLink = "assets/images/card-attendance.png";
  static const String addAttendanceImageLink = "assets/images/add-attendance.png";

  // Drawer Texts
  static const String drawerHome = "Home";
  static const String drawerUsers = "Users";
  static const String drawerCompanies = "Companies";
  static const String drawerAttendances = "Attendances";
  static const String drawerSignOut = "Sign Out";

  // Card Texts
  static const String cardCompanyName = "Name";
  static const String cardCompanyLocation = "Location";
  static const String cardUsername = "Username";
  static const String cardUserEmail = "Email";
  static const String cardUserCompany = "Company";
  static const String cardAttendanceUserName = "Name";
  static const String cardAttendanceDate = "Date";
  static const String cardAttendanceStartTime = "Start time";
  static const String cardAttendanceEndTime = "End time";
  static const String cardAttendanceUserCompany = "Company";
  static const String cardAttendanceWorkedHours = "Worked hours";
  static const String notYetRecordedText = "Not yet recorded";
  static const String notYetCalculatedText = "Not yet calculated";
  static const String adminCardCompanyTitle = "COMPANIES";
  static const String adminCardUserTitle = "USERS";
  static const String adminCardAttendancesTitle = "ATTENDANCES";
  static const String adminCardCompanySubTitle = "Manage company details.";
  static const String adminCardUserSubTitle = "Manage user details.";
  static const String adminCardAttendancesSubTitle = "Manage attendance details.";

  // Alert Texts
  static const String alertTitle = "ALERT";
  static const String alertDeleteContent = "Are you sure you want to delete this content.";
  static const String alertUpdateContent = "Are you sure you want to update this content.";
  static const String alertAddContent = "Are you sure you want to add this content.";
  static const String alertAddStartTime = "Are you sure you want to add start time now.";
  static const String alertAddEndTime = "Are you sure you want to add end time now.";
  static const String alertResetPassword = "Are you sure you want to reset your password.";
  static const String alertButtonConfirm = "CONFIRM";
  static const String alertButtonCancel = "CANCEL";
  static const String alertButtonOk = "OK";

  // Screen Texts
  static const String addStartTimeText =
      "⚠️ Please tap on the finger print image to enter your start time. Please note that the start time can be set only once per day.";
  static const String addEndTimeText =
      "⚠️ Please tap on the finger print image to enter your end time. Please note that the end time can be set only once per day and the end time can be set only if you have previously set the start time for that day.";
}
