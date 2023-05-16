import '../utils/variables/text_values.dart';

class ValidatorService {

  // User Validations 
  static String? Function(String?)? validateUsername = (value) {
    if (value!.isEmpty) {
      return TextValues.emptyValueValidation;
    } else {
      return null;
    }
  };

  static String? Function(String?)? validatePassword = (value) {
    if (value!.isEmpty) {
      return TextValues.emptyValueValidation;
    } else if (value.length < 6) {
      return TextValues.passwordLengthValidation;
    }
    return null;
  };

  static String? Function(String?)? validateEmail = (value) {
    if (value!.isEmpty) {
      return TextValues.emptyValueValidation;
    } else if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return null;
    } else {
      return TextValues.emailValidation;
    }
  };

  static String? Function(String?)? validateOTP = (value) {
    if (value!.isEmpty) {
      return TextValues.emptyValueValidation;
    } else if (value.length < 4) {
      return TextValues.passwordLengthValidation;
    }
    return null;
  };

  static String? Function(String?)? validateConfirmPassword = (value) {
    if (value!.isEmpty) {
      return TextValues.emptyValueValidation;
    } else if (value.length < 6) {
      return TextValues.passwordLengthValidation;
    }
    return null;
  };

  // Company Validations 
  static String? Function(String?)? validateCompanyName = (value) {
    if (value!.isEmpty) {
      return TextValues.emptyValueValidation;
    } else {
      return null;
    }
  };

  static String? Function(String?)? validateCompanyLocation = (value) {
    if (value!.isEmpty) {
      return TextValues.emptyValueValidation;
    } else {
      return null;
    }
  };

}
