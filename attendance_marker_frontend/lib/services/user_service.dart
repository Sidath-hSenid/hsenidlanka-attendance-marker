import 'package:attendance_marker_frontend/screens/admin_home_screen.dart';
import 'package:attendance_marker_frontend/screens/login_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_users_screen.dart';
import 'package:attendance_marker_frontend/screens/user_home_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/backend_api_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/model_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/text_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      if (response.data[ModelConstants.apiStatusCode] == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var accessToken =
            response.data[ModelConstants.apiJwtResponse][ModelConstants.token];
        var userId =
            response.data[ModelConstants.apiJwtResponse][ModelConstants.userId];
        prefs.setString(ModelConstants.token, accessToken);
        prefs.setString(ModelConstants.sharedUserId, userId);

        if (response.data[ModelConstants.apiJwtResponse]
                    [ModelConstants.userRoles]
                .toString() ==
            ModelConstants.authRole.toString()) {
          Response res;
          res = await dio.get(
              BackendAPIConstants.rootAPI +
                  BackendAPIConstants.getUserByIdAPI +
                  userId,
              options: Options(
                contentType: Headers.jsonContentType,
                headers: {ModelConstants.auth: "Bearer $accessToken"},
              ));

          if (res.data[ModelConstants.apiStatusCode] == 200) {
            var userId = res.data[ModelConstants.apiUserResponse]
                    [ModelConstants.userId]
                .toString();
            var username = res.data[ModelConstants.apiUserResponse]
                    [ModelConstants.username]
                .toString();
            var email = res.data[ModelConstants.apiUserResponse]
                    [ModelConstants.email]
                .toString();
            var companyId = res.data[ModelConstants.apiUserResponse]
                    [ModelConstants.company][ModelConstants.companyId]
                .toString();
            var companyName = res.data[ModelConstants.apiUserResponse]
                    [ModelConstants.company][ModelConstants.companyName]
                .toString();
            var companyLocation = res.data[ModelConstants.apiUserResponse]
                    [ModelConstants.company][ModelConstants.companyLocation]
                .toString();

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
              MaterialPageRoute(builder: (context) => const AdminHomeScreen()));

          ToastWidget.functionToastWidget(
              TextConstants.signInButtonSuccessToast,
              ColorConstants.toastSuccessColor);
        }
      } else if (response.statusCode == 401) {
        ToastWidget.functionToastWidget(
            TextConstants.signInButtonInvalidErrorToast,
            ColorConstants.toastErrorColor);
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          TextConstants.signInButtonInvalidErrorToast,
          ColorConstants.toastErrorColor);
    }
  }

  // ---------------------------------------------- Login Function End ----------------------------------------------

  // ---------------------------------------------- Add User Function Start ----------------------------------------------

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
      if (response.data[ModelConstants.apiStatusCode] == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ManageUsersScreen()));

        ToastWidget.functionToastWidget(TextConstants.signUpButtonSuccessToast,
            ColorConstants.toastSuccessColor);
      } else if ((response.data[ModelConstants.apiStatusCode] == 403)) {
        ToastWidget.functionToastWidget(
            TextConstants.signUpButtonAlreadyErrorToast,
            ColorConstants.toastSuccessColor);
      } else if (response.data[ModelConstants.apiStatusCode] == 400) {
        ToastWidget.functionToastWidget(
            TextConstants.badRequest, ColorConstants.toastErrorColor);
      } else {
        ToastWidget.functionToastWidget(TextConstants.signUpButtonErrorToast,
            ColorConstants.toastErrorColor);
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Add User Function End ----------------------------------------------

  // ---------------------------------------------- Reset Password Function Start ----------------------------------------------

  resetPassword(username, email, password, context) async {
    Response response;
    try {
      response = await dio.put(
          BackendAPIConstants.rootAPI +
              BackendAPIConstants.resetPasswordAPI +
              username +
              ModelConstants.addParams +
              email,
          data: {
            ModelConstants.password: password,
          },
          options: Options(contentType: Headers.jsonContentType));
      if (response.data[ModelConstants.apiStatusCode] == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        ToastWidget.functionToastWidget(
            TextConstants.resetPasswordButtonSuccessToast,
            ColorConstants.toastSuccessColor);
      } else if (response.data[ModelConstants.apiStatusCode] == 404) {
        Navigator.of(context).pop();

        ToastWidget.functionToastWidget(
            TextConstants.noDataFound, ColorConstants.toastErrorColor);
      } else if (response.data[ModelConstants.apiStatusCode] == 400) {
        Navigator.of(context).pop();

        ToastWidget.functionToastWidget(
            TextConstants.badRequest, ColorConstants.toastErrorColor);
      } else {
        Navigator.of(context).pop();

        ToastWidget.functionToastWidget(
            TextConstants.resetPasswordButtonErrorToast,
            ColorConstants.toastErrorColor);
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          TextConstants.resetPasswordButtonErrorToast,
          ColorConstants.toastErrorColor);
    }
  }

  // ---------------------------------------------- Reset Password Function End ----------------------------------------------

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

      if (response.data[ModelConstants.apiStatusCode] == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ManageUsersScreen()));

        ToastWidget.functionToastWidget(TextConstants.updateUserSuccessToast,
            ColorConstants.toastSuccessColor);
      } else if (response.data[ModelConstants.apiStatusCode] == 404) {
        ToastWidget.functionToastWidget(
            TextConstants.noDataFound, ColorConstants.toastErrorColor);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SingleUserScreen(
                    useId: userId,
                    usename: username,
                    useEmail: email,
                    useCompany: company)));
      } else if (response.data[ModelConstants.apiStatusCode] == 400) {
        ToastWidget.functionToastWidget(
            TextConstants.badRequest, ColorConstants.toastErrorColor);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SingleUserScreen(
                    useId: userId,
                    usename: username,
                    useEmail: email,
                    useCompany: company)));
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

  // ---------------------------------------------- Update User By Id Function End ----------------------------------------------

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

      if (response.data[ModelConstants.apiStatusCode] == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ManageUsersScreen()));

        ToastWidget.functionToastWidget(TextConstants.deleteUserSuccessToast,
            ColorConstants.toastSuccessColor);
      } else if (response.data[ModelConstants.apiStatusCode] == 404) {
        ToastWidget.functionToastWidget(
            TextConstants.noDataFound, ColorConstants.toastErrorColor);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ManageUsersScreen()));
      } else if (response.data[ModelConstants.apiStatusCode] == 400) {
        ToastWidget.functionToastWidget(
            TextConstants.deleteUserErrorToast, ColorConstants.toastErrorColor);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ManageUsersScreen()));
      } else {
        ToastWidget.functionToastWidget(
            TextConstants.badRequest, ColorConstants.toastErrorColor);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ManageUsersScreen()));
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Delete User By Id Function End ----------------------------------------------

  // ---------------------------------------------- Log Out Function Start ----------------------------------------------

  logOut(context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      response = await dio.post(
        BackendAPIConstants.rootAPI + BackendAPIConstants.logoutAPI,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      if (response.data[ModelConstants.apiStatusCode] == 200) {
        prefs.remove(ModelConstants.token);
        prefs.remove(ModelConstants.sharedUserId);
        prefs.remove(ModelConstants.username);
        prefs.remove(ModelConstants.email);
        prefs.remove(ModelConstants.sharedCompanyId);
        prefs.remove(ModelConstants.companyName);
        prefs.remove(ModelConstants.companyLocation);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));

        ToastWidget.functionToastWidget(TextConstants.signOutButtonSuccessToast,
            ColorConstants.toastSuccessColor);
      } else {
        ToastWidget.functionToastWidget(TextConstants.signOutButtonErrorToast,
            ColorConstants.toastErrorColor);

        Navigator.of(context).pop();
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Log Out Function End ----------------------------------------------
}
