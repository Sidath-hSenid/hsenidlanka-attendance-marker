import 'package:attendance_marker_frontend/screens/manage_attendances_screen.dart';
import 'package:attendance_marker_frontend/screens/single_attendance_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/backend_api_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/model_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/text_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:geocoding/geocoding.dart';

import '../utils/widgets/toast_widget.dart';

class AttendanceService {
  Dio dio = Dio();

  // // Get Location
  // Future<String> getCurrentLocationPlusCode() async {
  //   try {
  //     final position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     final addresses = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );

  //     final address = addresses.first;
  //     return address.;
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  // ---------------------------------------------- Add New Attendance Function Start ----------------------------------------------
  addAttendance(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      DateTime today = DateTime.now();
      String date = "${today.year}-${today.month}-${today.day}";
      String startTime = "${today.hour}:${today.minute}";
      String? location = "7JVP+3RH Kandy";
      // String location = await getCurrentLocationPlusCode();

      String userId = prefs.getString(ModelConstants.sharedUserId).toString();
      String username = prefs.getString(ModelConstants.username).toString();
      String email = prefs.getString(ModelConstants.email).toString();
      String companyName =
          prefs.getString(ModelConstants.companyName).toString();
      String companyId =
          prefs.getString(ModelConstants.sharedCompanyId).toString();
      String companyLocation =
          prefs.getString(ModelConstants.companyLocation).toString();
      if (location.toString() == companyLocation) {
        Response res;
        res = await dio.get(
          BackendAPIConstants.rootAPI +
              BackendAPIConstants.getAttendanceByUserIdAndDateAPI +
              userId +
              ModelConstants.addParams +
              date,
          options: Options(
            contentType: Headers.jsonContentType,
            headers: {ModelConstants.auth: "Bearer $accessToken"},
          ),
        );
        if (res.statusCode == 200) {
          if (res.data[ModelConstants.attendanceId] == null) {
            Response response;
            response = await dio.post(
              BackendAPIConstants.rootAPI +
                  BackendAPIConstants.addAttendanceAPI,
              data: {
                ModelConstants.date: date,
                ModelConstants.startTime: startTime,
                ModelConstants.endTime: null,
                ModelConstants.workedHours: 0,
                ModelConstants.halfDay: false,
                ModelConstants.user: {
                  ModelConstants.userId: userId,
                  ModelConstants.username: username,
                  ModelConstants.email: email,
                  ModelConstants.password: null,
                  ModelConstants.company: {
                    ModelConstants.companyId: companyId,
                    ModelConstants.companyName: companyName,
                    ModelConstants.companyLocation: companyLocation
                  }
                },
              },
              options: Options(
                contentType: Headers.jsonContentType,
                headers: {ModelConstants.auth: "Bearer $accessToken"},
              ),
            );

            if (response.statusCode == 201) {
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => const UserHomeScreen()));
              var sharedAttendanceId =
                  response.data[ModelConstants.attendanceId];
              prefs.setString(ModelConstants.sharedAttendanceId,
                  sharedAttendanceId.toString());
              prefs.setString(ModelConstants.startTime, today.toString());
              ToastWidget.functionToastWidget(
                  TextConstants.addAttendanceSuccessToast,
                  ColorConstants.toastSuccessColor);
            } else {
              ToastWidget.functionToastWidget(
                  TextConstants.addAttendanceErrorToast,
                  ColorConstants.toastErrorColor);

              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => UserHomeScreen()));
            }
          } else {
            // Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => const UserHomeScreen()));
            ToastWidget.functionToastWidget(
                TextConstants.alreadyAddedAttendanceErrorToast,
                ColorConstants.toastErrorColor);
          }
        } else {}
      } else {
        // Navigator.pushReplacement(context,
        //       MaterialPageRoute(builder: (context) => const UserHomeScreen()));
        ToastWidget.functionToastWidget(
            TextConstants.attendanceLocationErrorToast,
            ColorConstants.toastErrorColor);
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Update Attendance End Time By Id Function Start ----------------------------------------------
  updateDayAttendanceEndTimeById(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      DateTime today = DateTime.now();
      String date = "${today.year}-${today.month}-${today.day}";
      String endTime = "${today.hour}:${today.minute}";
      String? location = "7JVP+3RH Kandy";
      // String location = await getCurrentLocationPlusCode();

      String companyLocation =
          prefs.getString(ModelConstants.companyLocation).toString();

      if (location.toString() == companyLocation) {
        var userId = prefs.getString(ModelConstants.sharedUserId).toString();
        Response res;
        res = await dio.get(
          BackendAPIConstants.rootAPI +
              BackendAPIConstants.getAttendanceByUserIdAndDateAPI +
              userId +
              ModelConstants.addParams +
              date,
          options: Options(
            contentType: Headers.jsonContentType,
            headers: {ModelConstants.auth: "Bearer $accessToken"},
          ),
        );

        if (res.statusCode == 200) {
          String atteResDate = res.data[ModelConstants.date].toString();
          var attendanceId = res.data[ModelConstants.attendanceId];
          var atteResEndDate = res.data[ModelConstants.endTime];
          var startTime = res.data[ModelConstants.startTime];

          if (date == atteResDate) {
            if (startTime != null) {
              if (atteResEndDate == null) {
                DateTime attStartTime = DateTime.parse(
                    prefs.getString(ModelConstants.startTime).toString());
                int timeDifference = today.difference(attStartTime).inHours;

                if (timeDifference.isNegative) {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => UserHomeScreen()));

                  ToastWidget.functionToastWidget(
                      TextConstants.startTimeValidation,
                      ColorConstants.toastErrorColor);
                } else {
                  double workedHours = double.parse(timeDifference.toString());
                  if (workedHours > ModelConstants.halfDayTime &&
                      workedHours < ModelConstants.fullDayTime) {
                    Response response;
                    response = await dio.put(
                      BackendAPIConstants.rootAPI +
                          BackendAPIConstants.updateAttendanceByIdAPI +
                          attendanceId.toString(),
                      data: {
                        ModelConstants.endTime: endTime,
                        ModelConstants.workedHours: workedHours,
                        ModelConstants.halfDay: ModelConstants.halfDayTrueBool
                      },
                      options: Options(
                        contentType: Headers.jsonContentType,
                        headers: {ModelConstants.auth: "Bearer $accessToken"},
                      ),
                    );

                    if (response.statusCode == 200) {
                      prefs.remove(ModelConstants.attendanceId);
                      prefs.remove(ModelConstants.startTime);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             const UserHomeScreen()));

                      ToastWidget.functionToastWidget(
                          TextConstants.updateAttendanceEndTimeSuccessToast,
                          ColorConstants.toastSuccessColor);
                    } else {
                      ToastWidget.functionToastWidget(
                          TextConstants.updateAttendanceEndTimeErrorToast,
                          ColorConstants.toastErrorColor);

                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => UserHomeScreen()));
                    }
                  } else if (workedHours >= ModelConstants.fullDayTime &&
                      workedHours < ModelConstants.overWorkedDayTime) {
                    Response response;
                    response = await dio.put(
                      BackendAPIConstants.rootAPI +
                          BackendAPIConstants.updateAttendanceByIdAPI +
                          attendanceId.toString(),
                      data: {
                        ModelConstants.endTime: endTime,
                        ModelConstants.workedHours: workedHours,
                        ModelConstants.halfDay: ModelConstants.halfDayFlaseBool
                      },
                      options: Options(
                        contentType: Headers.jsonContentType,
                        headers: {ModelConstants.auth: "Bearer $accessToken"},
                      ),
                    );

                    if (response.statusCode == 200) {
                      prefs.remove(ModelConstants.attendanceId);
                      prefs.remove(ModelConstants.startTime);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             const UserHomeScreen()));

                      ToastWidget.functionToastWidget(
                          TextConstants.updateAttendanceEndTimeSuccessToast,
                          ColorConstants.toastSuccessColor);
                    } else {
                      ToastWidget.functionToastWidget(
                          TextConstants.updateAttendanceEndTimeErrorToast,
                          ColorConstants.toastErrorColor);

                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => UserHomeScreen()));
                    }
                  } else {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => UserHomeScreen()));

                    ToastWidget.functionToastWidget(
                        TextConstants.wrongTimeRangeErrorToast,
                        ColorConstants.toastErrorColor);
                  }
                }
              } else {
                ToastWidget.functionToastWidget(
                    TextConstants.alreadyUpdatedAttendanceErrorToast,
                    ColorConstants.toastErrorColor);
              }
            } else {
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => UserHomeScreen()));

              ToastWidget.functionToastWidget(
                  TextConstants.haveNotAddedAttendanceErrorToast,
                  ColorConstants.toastErrorColor);
            }
          } else {
            // Date Validation
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => const UserHomeScreen()));

            ToastWidget.functionToastWidget(
                TextConstants.attendanceDateErrorToast,
                ColorConstants.toastErrorColor);
          }
        } else {
          ToastWidget.functionToastWidget(
              TextConstants.updateAttendanceEndTimeErrorToast,
              ColorConstants.toastErrorColor);
        }
      } else {
        // Navigator.pushReplacement(context,
        //       MaterialPageRoute(builder: (context) => const UserHomeScreen()));
        ToastWidget.functionToastWidget(
            TextConstants.attendanceLocationErrorToast,
            ColorConstants.toastErrorColor);
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Update Attendance By Id Function Start ----------------------------------------------
  updateAttendanceById(date, attendanceId, startTime, endTime, workedHours,
      username, companyName, companyLocation, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      response = await dio.put(
        BackendAPIConstants.rootAPI +
            BackendAPIConstants.updateAttendanceByIdAPI +
            attendanceId,
        data: {
          ModelConstants.startTime: startTime,
          ModelConstants.endTime: endTime,
          ModelConstants.workedHours: workedHours,
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
                builder: (context) => const ManageAttendancesScreen()));

        ToastWidget.functionToastWidget(
            TextConstants.updateAttendanceSuccessToast,
            ColorConstants.toastSuccessColor);
      } else {
        ToastWidget.functionToastWidget(
            TextConstants.updateAttendanceErrorToast,
            ColorConstants.toastErrorColor);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SingleAttendanceScreen(
                      attId: attendanceId,
                      attDate: date,
                      attStartTime: startTime,
                      attEndTime: endTime,
                      attWorkedHours: (workedHours).toString(),
                      attUsername: username,
                      attCompanyName: companyName,
                      attCompanyLocation: companyLocation,
                    )));
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Delete Attendance By Id Function Start ----------------------------------------------
  deleteAttendanceById(attendanceId, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      response = await dio.delete(
        BackendAPIConstants.rootAPI +
            BackendAPIConstants.deleteAttendanceByIdAPI +
            attendanceId,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageAttendancesScreen()));

        ToastWidget.functionToastWidget(
            TextConstants.deleteAttendanceSuccessToast,
            ColorConstants.toastSuccessColor);
      } else {
        ToastWidget.functionToastWidget(
            TextConstants.deleteAttendanceErrorToast,
            ColorConstants.toastErrorColor);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageAttendancesScreen()));
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }
}
