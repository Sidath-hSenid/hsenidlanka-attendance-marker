// ignore_for_file: avoid_print

import 'package:attendance_marker_frontend/screens/add_start_time_screen.dart';
import 'package:attendance_marker_frontend/screens/all_companies_screen.dart';
import 'package:attendance_marker_frontend/screens/reset_password_screen.dart';
import 'package:attendance_marker_frontend/screens/user_home_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/backend_api_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/model_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/text_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/all_users_screen.dart';
import '../screens/single_user_screen.dart';
import '../utils/widgets/toast_widget.dart';

class UserService {
  Dio dio = Dio();

  // ---------------------------------------------- Login Function Start ----------------------------------------------
  login(username, password, context) async {
    Response response;
    try {
      response = await dio.post(
          BackendAPIConstants.rootAPI + BackendAPIConstants.loginAPI,
          data: {
            ModelConstants.username: username,
            ModelConstants.password: password,
          },
          options: Options(contentType: Headers.jsonContentType));
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var accessToken = response.data[ModelConstants.token];
        var userId = response.data[ModelConstants.userId];
        prefs.setString(ModelConstants.token, accessToken);
        prefs.setString(ModelConstants.userId, userId);

        if (response.data[ModelConstants.userRoles].toString() == ModelConstants.authRole.toString()) {
          Response res;
          res = await dio.get(
              BackendAPIConstants.rootAPI +
                  BackendAPIConstants.getUserByIdAPI +
                  userId,
              options: Options(
                contentType: Headers.jsonContentType,
                headers: {ModelConstants.auth: "Bearer $accessToken"},
              ));

          if (res.statusCode == 200) {
            var userId = res.data[ModelConstants.userId].toString();
            var username = res.data[ModelConstants.username].toString();
            var email = res.data[ModelConstants.email].toString();
             var companyId = res.data[ModelConstants.company]
                [ModelConstants.companyId].toString();
            var companyName = res.data[ModelConstants.company]
                [ModelConstants.companyName].toString();
            var companyLocation = res.data[ModelConstants.company]
                [ModelConstants.companyLocation].toString();

            prefs.setString(ModelConstants.sharedUserId, userId);
            prefs.setString(ModelConstants.username, username);
            prefs.setString(ModelConstants.email, email);
            prefs.setString(ModelConstants.sharedCompanyId, companyId);
            prefs.setString(ModelConstants.companyName, companyName);
            prefs.setString(ModelConstants.companyLocation, companyLocation);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserHomeScreen()));

            ToastWidget.functionToastWidget(
                TextConstants.signInButtonSuccessToast,
                ColorConstants.toastSuccessColor);
          }
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AllUsersScreen()));

          ToastWidget.functionToastWidget(
              TextConstants.signInButtonSuccessToast,
              ColorConstants.toastSuccessColor);
        }
      } else {
        ToastWidget.functionToastWidget(TextConstants.signInButtonErrorToast,
            ColorConstants.toastErrorColor);
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  addUser(username, email, password, company, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      response = await dio.post(
          BackendAPIConstants.rootAPI + BackendAPIConstants.registerAPI,
          data: {
            ModelConstants.username: username,
            ModelConstants.email: email,
            ModelConstants.password: password,
            ModelConstants.userRoles: [ModelConstants.userRole],
            ModelConstants.company: company,
          },
          options: Options(
            contentType: Headers.jsonContentType,
            headers: {ModelConstants.auth: "Bearer $accessToken"},
          ));
      if (response.statusCode == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AllUsersScreen()));

        ToastWidget.functionToastWidget(TextConstants.signUpButtonSuccessToast,
            ColorConstants.toastSuccessColor);
      } else if (response.statusCode == 400) {
        ToastWidget.functionToastWidget(
            TextConstants.signUpButtonAlreadyErrorToast,
            ColorConstants.toastSuccessColor);
      } else {
        ToastWidget.functionToastWidget(TextConstants.signInButtonErrorToast,
            ColorConstants.toastErrorColor);
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Forgot Password Function Start ----------------------------------------------
  forgotPassword(email) async {
    try {
      await dio.post(
          BackendAPIConstants.rootAPI + BackendAPIConstants.forgotPasswordAPI,
          data: {
            ModelConstants.email: email,
          },
          options: Options(contentType: Headers.jsonContentType));

      // return Get.off(() => MainMenu());
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Validate OTP Function Start ----------------------------------------------
  validateOTP(otp) async {
    try {
      await dio.post(
          BackendAPIConstants.rootAPI + BackendAPIConstants.validateOTPAPI,
          data: {
            'otp': otp,
          },
          options: Options(contentType: Headers.jsonContentType));

      // return Get.off(() => MainMenu());
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Reset Password Function Start ----------------------------------------------
  resetPassword(password) async {
    try {
      await dio.post(
          BackendAPIConstants.rootAPI + BackendAPIConstants.resetPasswordAPI,
          data: {
            'password': password,
          },
          options: Options(contentType: Headers.jsonContentType));

      // return Get.off(() => MainMenu());
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Update User By Id Function Start ----------------------------------------------
  updateUserById(userId, username, email, company, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);

    try {
      response = await dio.put(
        BackendAPIConstants.rootAPI +
            BackendAPIConstants.updateUserByIdAPI +
            userId,
        data: {
          ModelConstants.username: username,
          ModelConstants.email: email,
          ModelConstants.company: company,
        },
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AllUsersScreen()));

        ToastWidget.functionToastWidget(TextConstants.updateUserSuccessToast,
            ColorConstants.toastSuccessColor);
      } else {
        ToastWidget.functionToastWidget(
            TextConstants.updateUserErrorToast, ColorConstants.toastErrorColor);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SingleUserScreen(
                    useId: userId,
                    usename: username,
                    useEmail: email,
                    useCompany: company)));
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Delete User By Id Function Start ----------------------------------------------
  deleteUserById(userId, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      response = await dio.delete(
        BackendAPIConstants.rootAPI +
            BackendAPIConstants.deleteUserByIdAPI +
            userId,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AllUsersScreen()));

        ToastWidget.functionToastWidget(TextConstants.deleteUserSuccessToast,
            ColorConstants.toastSuccessColor);
      } else {
        ToastWidget.functionToastWidget(
            TextConstants.deleteUserErrorToast, ColorConstants.toastErrorColor);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AllUsersScreen()));
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }
}
