import 'package:attendance_marker_frontend/screens/manage_companies_screen.dart';
import 'package:attendance_marker_frontend/screens/single_company_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/model_constants.dart';
import 'package:attendance_marker_frontend/utils/widgets/toast_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/backend_api_constants.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/text_constants.dart';

class CompanyService {

  Dio dio = Dio();

  // ---------------------------------------------- Add Company Function Start ----------------------------------------------
  
  addCompany(companyName, companyLocation, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);

    try {
      response = await dio.post(
        BackendAPIConstants.rootAPI + BackendAPIConstants.addCompanyAPI,
        data: {
          ModelConstants.companyName: companyName,
          ModelConstants.companyLocation: companyLocation,
        },
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 201) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageCompaniesScreen()));

        ToastWidget.functionToastWidget(
            TextConstants.addCompanyButtonSuccessToast,
            ColorConstants.toastSuccessColor);
      } else if (response.statusCode == 400) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageCompaniesScreen()));

        ToastWidget.functionToastWidget(
            TextConstants.addCompanyButtonAlreadyErrorToast,
            ColorConstants.toastErrorColor);
      } else {
        ToastWidget.functionToastWidget(
            TextConstants.addCompanyButtonErrorToast,
            ColorConstants.toastErrorColor);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageCompaniesScreen()));
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          TextConstants.addCompanyButtonAlreadyErrorToast,
          ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Add Company Function End ----------------------------------------------

  // ---------------------------------------------- Update Company By Id Function Start ----------------------------------------------
  
  updateCompanyById(companyId, companyName, companyLocation, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);

    try {
      response = await dio.put(
        BackendAPIConstants.rootAPI +
            BackendAPIConstants.updateCompanyByIdAPI +
            companyId,
        data: {
          ModelConstants.companyName: companyName,
          ModelConstants.companyLocation: companyLocation,
        },
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageCompaniesScreen()));

        ToastWidget.functionToastWidget(TextConstants.updateCompanySuccessToast,
            ColorConstants.toastSuccessColor);
      } else {
        ToastWidget.functionToastWidget(TextConstants.updateCompanyErrorToast,
            ColorConstants.toastErrorColor);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SingleCompanyScreen(
                    comId: companyId,
                    comName: companyName,
                    comLocation: companyLocation)));
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Update Company By Id Function End ----------------------------------------------

  // ---------------------------------------------- Delete Company By Id Function Start ----------------------------------------------
  
  deleteCompanyById(companyId, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      response = await dio.delete(
        BackendAPIConstants.rootAPI +
            BackendAPIConstants.deleteCompanyByIdAPI +
            companyId,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      if (response.data[ModelConstants.statCode] != 400) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageCompaniesScreen()));

        ToastWidget.functionToastWidget(TextConstants.deleteCompanySuccessToast,
            ColorConstants.toastSuccessColor);
      } else {
        ToastWidget.functionToastWidget(TextConstants.deleteCompanyErrorToast,
            ColorConstants.toastErrorColor);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageCompaniesScreen()));
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Delete Company By Id Function End ----------------------------------------------

}

