import 'package:attendance_marker_frontend/utils/variables/backend_api.dart';
import 'package:attendance_marker_frontend/utils/variables/color_palette.dart';
import 'package:attendance_marker_frontend/utils/variables/size_values.dart';
import 'package:attendance_marker_frontend/utils/variables/text_values.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserService{

  Dio dio = Dio();

  
  login(username, password) async {
    try {
      await dio.post(BackendAPI.loginAPI,
          data: {
            'username': username,
            'password': password,
          },
          options: Options(contentType: Headers.jsonContentType));

      // return Get.off(() => MainMenu());
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: TextValues.userServiceLoginErrorToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorPalette.toastErrorColor,
          textColor: ColorPalette.toastTextColor,
          fontSize: SizeValues.toastFontSize);
    }
  }

  forgotPassword(email) async {
    try {
      await dio.post(BackendAPI.forgotPasswordAPI,
          data: {
            'email': email,
          },
          options: Options(contentType: Headers.jsonContentType));

      // return Get.off(() => MainMenu());
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: TextValues.userServiceForgotPasswordErrorToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorPalette.toastErrorColor,
          textColor: ColorPalette.toastTextColor,
          fontSize: SizeValues.toastFontSize);
    }
  }

  validateOTP(otp) async {
    try {
      await dio.post(BackendAPI.validateOTPAPI,
          data: {
            'otp': otp,
          },
          options: Options(contentType: Headers.jsonContentType));

      // return Get.off(() => MainMenu());
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: TextValues.userServiceValidateOTPErrorToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorPalette.toastErrorColor,
          textColor: ColorPalette.toastTextColor,
          fontSize: SizeValues.toastFontSize);
    }
  }

  resetPassword(password) async {
    try {
      await dio.post(BackendAPI.resetPasswordAPI,
          data: {
            'password': password,
          },
          options: Options(contentType: Headers.jsonContentType));

      // return Get.off(() => MainMenu());
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: TextValues.userServiceResetPasswordErrorToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorPalette.toastErrorColor,
          textColor: ColorPalette.toastTextColor,
          fontSize: SizeValues.toastFontSize);
    }
  }

}