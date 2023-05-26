// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:attendance_marker_frontend/screens/manage_attendances_screen.dart';
import 'package:attendance_marker_frontend/screens/single_attendance_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/backend_api_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/model_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/text_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:geocoding/geocoding.dart';

import '../screens/user_home_screen.dart';
import '../utils/constants/size_constants.dart';
import '../utils/widgets/toast_widget.dart';

class AttendanceService {
  Dio dio = Dio();

  // ---------------------------------------------- Get Current Location Function Start ----------------------------------------------

  Future<String> getCurrentLocationPlusCode() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final addresses = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final address = addresses.first;
      return address.name.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // ---------------------------------------------- Get Current Location Function End ----------------------------------------------

  // ---------------------------------------------- Add New Attendance Function Start ----------------------------------------------

  addAttendance(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      log("AttendanceService - addAttendance()");
      DateTime today = DateTime.now();
      String date = "${today.year}-${today.month}-${today.day}";
      String startTime = "${today.hour}:${today.minute}";
      String location = await getCurrentLocationPlusCode();
      log("Location, Date and Time. $date, $startTime And $location");

      String userId = prefs.getString(ModelConstants.sharedUserId).toString();
      String username = prefs.getString(ModelConstants.username).toString();
      String email = prefs.getString(ModelConstants.email).toString();
      String companyName =
          prefs.getString(ModelConstants.companyName).toString();
      String companyId =
          prefs.getString(ModelConstants.sharedCompanyId).toString();
      String companyLocation =
          prefs.getString(ModelConstants.companyLocation).toString();
      if (location == companyLocation) {
        log("AttendanceService - addAttendance(Locations are equal)");
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
          log(
              "AttendanceService - addAttendance(Status code equals to 200)");
          if (res.data[ModelConstants.attendanceId] == null) {
            log(
                "AttendanceService - addAttendance(No attendance available with the user ID and Date)");
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
              log(
                  "AttendanceService - addAttendance(New attendance added to the user ID(${res.data[ModelConstants.attendanceId]}) for date($date))");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserHomeScreen()));
              ToastWidget.functionToastWidget(
                  TextConstants.addAttendanceSuccessToast,
                  ColorConstants.toastSuccessColor);
            } else {
              ToastWidget.functionToastWidget(
                  TextConstants.addAttendanceErrorToast,
                  ColorConstants.toastErrorColor);

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserHomeScreen()));
            }
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      TextConstants.alertTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConstants.alertTitleFontSize,
                          color: ColorConstants.errorBorder),
                    ),
                    content: const Text(
                      TextConstants.alreadyAddedAttendanceErrorToast,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: SizeConstants.alertContentFontSize,
                          color: ColorConstants.errorBorder),
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          TextConstants.alertButtonOk,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConstants.alertButtonFontSize,
                              color: ColorConstants.errorBorder),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          }
        } else {}
      } else {
        log(
            "AttendanceService - addAttendance(Locations are not equal.)");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  TextConstants.alertTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConstants.alertTitleFontSize,
                      color: ColorConstants.errorBorder),
                ),
                content: const Text(
                  TextConstants.attendanceLocationErrorToast,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConstants.alertContentFontSize,
                      color: ColorConstants.errorBorder),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      TextConstants.alertButtonOk,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConstants.alertButtonFontSize,
                          color: ColorConstants.errorBorder),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    } on DioError catch (e) {
      print(e);
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Add New Attendance Function End ----------------------------------------------

  // ---------------------------------------------- Update Attendance End Time By Id Function Start ----------------------------------------------

  updateDayAttendanceEndTimeById(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    try {
      log("AttendanceService - updateDayAttendanceEndTimeById()");
      DateTime today = DateTime.now();
      String date = "${today.year}-${today.month}-${today.day}";
      String endTime = "${today.hour}:${today.minute}";
      String location = await getCurrentLocationPlusCode();
      log("Location, Date and Time. $date, $endTime And $location");
      String companyLocation =
          prefs.getString(ModelConstants.companyLocation).toString();

      if (location == companyLocation) {
        log(
            "AttendanceService - updateDayAttendanceEndTimeById(Locations are equal)");
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
          log(
              "AttendanceService - addAttendance(Status code equals to 200)");
          String atteResDate = res.data[ModelConstants.date].toString();
          var attendanceId = res.data[ModelConstants.attendanceId];
          var atteResEndTime = res.data[ModelConstants.endTime];
          var startTime = res.data[ModelConstants.startTime];

          if (date == atteResDate) {
            log(
                "AttendanceService - addAttendance(Two dates are equal)");
            if (startTime != null) {
              log(
                  "AttendanceService - addAttendance(Start time is available)");
              if (atteResEndTime == null) {
                log(
                    "AttendanceService - addAttendance(No recorded end time)");

                var format = DateFormat("HH:mm");
                var start = format.parse(startTime);
                var end = format.parse(endTime);
                var timeDifference = end.difference(start);
                var workedHours = double.parse(timeDifference.inHours.toString());

                log(
                    "AttendanceService - addAttendance(Start time - $startTime, End time - $endTime, Time difference - $timeDifference, Worked hours - $workedHours)");

                if (timeDifference.isNegative) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserHomeScreen()));

                  ToastWidget.functionToastWidget(
                      TextConstants.startTimeValidation,
                      ColorConstants.toastErrorColor);
                } else {
                    if (workedHours > ModelConstants.halfDayTime &&
                        workedHours < ModelConstants.fullDayTime) {
                          log(
                    "AttendanceService - addAttendance(Half day)");
                      Response response;
                      response = await dio.put(
                        BackendAPIConstants.rootAPI +
                            BackendAPIConstants.updateAttendanceEndTimeByIdAPI +
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserHomeScreen()));

                        ToastWidget.functionToastWidget(
                            TextConstants.updateAttendanceEndTimeSuccessToast,
                            ColorConstants.toastSuccessColor);
                      } else {
                        ToastWidget.functionToastWidget(
                            TextConstants.updateAttendanceEndTimeErrorToast,
                            ColorConstants.toastErrorColor);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserHomeScreen()));
                      }
                    } else if (workedHours >= ModelConstants.fullDayTime &&
                        workedHours < ModelConstants.overWorkedDayTime) {
                      log("AttendanceService - addAttendance(Full day)");
                      Response response;
                      response = await dio.put(
                        BackendAPIConstants.rootAPI +
                            BackendAPIConstants.updateAttendanceEndTimeByIdAPI +
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserHomeScreen()));

                        ToastWidget.functionToastWidget(
                            TextConstants.updateAttendanceEndTimeSuccessToast,
                            ColorConstants.toastSuccessColor);
                      } else {
                        ToastWidget.functionToastWidget(
                            TextConstants.updateAttendanceEndTimeErrorToast,
                            ColorConstants.toastErrorColor);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserHomeScreen()));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                TextConstants.alertTitle,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConstants.alertTitleFontSize,
                                    color: ColorConstants.errorBorder),
                              ),
                              content: const Text(
                                TextConstants.wrongTimeRangeErrorToast,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: SizeConstants.alertContentFontSize,
                                    color: ColorConstants.errorBorder),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    TextConstants.alertButtonOk,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConstants.alertButtonFontSize,
                                        color: ColorConstants.errorBorder),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                }
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          TextConstants.alertTitle,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConstants.alertTitleFontSize,
                              color: ColorConstants.errorBorder),
                        ),
                        content: const Text(
                          TextConstants.alreadyUpdatedAttendanceErrorToast,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: SizeConstants.alertContentFontSize,
                              color: ColorConstants.errorBorder),
                        ),
                        actions: [
                          TextButton(
                            child: const Text(
                              TextConstants.alertButtonOk,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConstants.alertButtonFontSize,
                                  color: ColorConstants.errorBorder),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        TextConstants.alertTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConstants.alertTitleFontSize,
                            color: ColorConstants.errorBorder),
                      ),
                      content: const Text(
                        TextConstants.haveNotAddedAttendanceErrorToast,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: SizeConstants.alertContentFontSize,
                            color: ColorConstants.errorBorder),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            TextConstants.alertButtonOk,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConstants.alertButtonFontSize,
                                color: ColorConstants.errorBorder),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      TextConstants.alertTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConstants.alertTitleFontSize,
                          color: ColorConstants.errorBorder),
                    ),
                    content: const Text(
                      TextConstants.attendanceDateErrorToast,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: SizeConstants.alertContentFontSize,
                          color: ColorConstants.errorBorder),
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          TextConstants.alertButtonOk,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConstants.alertButtonFontSize,
                              color: ColorConstants.errorBorder),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          }
        } else {
          ToastWidget.functionToastWidget(
              TextConstants.updateAttendanceEndTimeErrorToast,
              ColorConstants.toastErrorColor);
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  TextConstants.alertTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConstants.alertTitleFontSize,
                      color: ColorConstants.errorBorder),
                ),
                content: const Text(
                  TextConstants.attendanceLocationErrorToast,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConstants.alertContentFontSize,
                      color: ColorConstants.errorBorder),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      TextConstants.alertButtonOk,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConstants.alertButtonFontSize,
                          color: ColorConstants.errorBorder),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Update Attendance End Time By Id Function End ----------------------------------------------

  // ---------------------------------------------- Update Attendance By Id Function Start ----------------------------------------------

  updateAttendanceById(attendanceId, startTime, endTime, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    debugPrint(
                  "AttendanceService - addAttendance(Attendance Id - $attendanceId, Start time - $startTime, End time - ${endTime.runtimeType})");
    try {
      if (startTime != null) {
              debugPrint(
                  "AttendanceService - addAttendance(Start time is available)");
              if (endTime != null) {
                debugPrint(
                    "AttendanceService - addAttendance(End time is available)");

                var format = DateFormat("HH:mm");
                var start = format.parse(startTime);
                var end = format.parse(endTime);
                var timeDifference = end.difference(start);
                var workedHours = double.parse(timeDifference.inHours.toString());

                debugPrint(
                    "AttendanceService - addAttendance(Start time - $startTime, End time - $endTime, Time difference - $timeDifference, Worked hours - $workedHours)");

                if (timeDifference.isNegative) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageAttendancesScreen()));

                  ToastWidget.functionToastWidget(
                      TextConstants.startTimeValidation,
                      ColorConstants.toastErrorColor);
                } else {
                    if (workedHours > ModelConstants.halfDayTime &&
                        workedHours < ModelConstants.fullDayTime) {
                          debugPrint(
                    "AttendanceService - addAttendance(Half day)");
                      Response response;
                      response = await dio.put(
                        BackendAPIConstants.rootAPI +
                            BackendAPIConstants.updateAttendanceByIdAPI +
                            attendanceId.toString(),
                        data: {
                          ModelConstants.startTime: startTime,
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ManageAttendancesScreen()));

                        ToastWidget.functionToastWidget(
                            TextConstants.updateAttendanceEndTimeSuccessToast,
                            ColorConstants.toastSuccessColor);
                      } else {
                        ToastWidget.functionToastWidget(
                            TextConstants.updateAttendanceEndTimeErrorToast,
                            ColorConstants.toastErrorColor);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserHomeScreen()));
                      }
                    } else if (workedHours >= ModelConstants.fullDayTime &&
                        workedHours < ModelConstants.overWorkedDayTime) {
                      debugPrint("AttendanceService - addAttendance(Full day)");
                      Response response;
                      response = await dio.put(
                        BackendAPIConstants.rootAPI +
                            BackendAPIConstants.updateAttendanceByIdAPI +
                            attendanceId.toString(),
                        data: {
                          ModelConstants.startTime: startTime,
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ManageAttendancesScreen()));

                        ToastWidget.functionToastWidget(
                            TextConstants.updateAttendanceEndTimeSuccessToast,
                            ColorConstants.toastSuccessColor);
                      } else {
                        ToastWidget.functionToastWidget(
                            TextConstants.updateAttendanceEndTimeErrorToast,
                            ColorConstants.toastErrorColor);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ManageAttendancesScreen()));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                TextConstants.alertTitle,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConstants.alertTitleFontSize,
                                    color: ColorConstants.errorBorder),
                              ),
                              content: const Text(
                                TextConstants.wrongTimeRangeErrorToast,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: SizeConstants.alertContentFontSize,
                                    color: ColorConstants.errorBorder),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    TextConstants.alertButtonOk,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConstants.alertButtonFontSize,
                                        color: ColorConstants.errorBorder),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                }
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          TextConstants.alertTitle,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConstants.alertTitleFontSize,
                              color: ColorConstants.errorBorder),
                        ),
                        content: const Text(
                          TextConstants.alreadyUpdatedAttendanceErrorToast,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: SizeConstants.alertContentFontSize,
                              color: ColorConstants.errorBorder),
                        ),
                        actions: [
                          TextButton(
                            child: const Text(
                              TextConstants.alertButtonOk,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConstants.alertButtonFontSize,
                                  color: ColorConstants.errorBorder),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        TextConstants.alertTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConstants.alertTitleFontSize,
                            color: ColorConstants.errorBorder),
                      ),
                      content: const Text(
                        TextConstants.haveNotAddedAttendanceErrorToast,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: SizeConstants.alertContentFontSize,
                            color: ColorConstants.errorBorder),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            TextConstants.alertButtonOk,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConstants.alertButtonFontSize,
                                color: ColorConstants.errorBorder),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Update Attendance By Id Function End ----------------------------------------------

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

// ---------------------------------------------- Delete Attendance By Id Function End ----------------------------------------------