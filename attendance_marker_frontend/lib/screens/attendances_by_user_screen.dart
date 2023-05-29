import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/attendance_service.dart';
import '../utils/constants/backend_api_constants.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/model_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/toast_widget.dart';
import '../utils/widgets/user_app_bar_widget.dart';

class AttendanceByUserScreen extends StatefulWidget {
  final useId;
  const AttendanceByUserScreen({Key? key, required this.useId})
      : super(key: key);

  @override
  State<AttendanceByUserScreen> createState() => _AttendanceByUserScreenState();
}

class _AttendanceByUserScreenState extends State<AttendanceByUserScreen> {
  var userId;
  bool isLoading = true;
  List attendances = [];
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getAllAttendances();
    setState(() {
      userId = widget.useId;
    });
  }

  // ---------------------------------------------- Get All Attendances Function Start ----------------------------------------------

  getAllAttendances() async {
    Dio dio = Dio();
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);

    try {
      response = await dio.get(
        BackendAPIConstants.rootAPI +
            BackendAPIConstants.getAttendanceByUserIdAPI +
            userId.toString(),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      if (response.data[ModelConstants.apiStatusCode] == 200) {
        var items = response.data[ModelConstants.apiAttendanceResponseList];
        // if (items.toString().length != 2) {
        if (items != null) {
          setState(() {
            attendances = items;
          });
          isLoading = false;
        } else {
          ToastWidget.functionToastWidget(TextConstants.allAttendanceErrorToast,
              ColorConstants.toastErrorColor);
          setState(() {
            attendances = [];
          });
        }
      } else if (response.data[ModelConstants.apiStatusCode] == 404) {
        ToastWidget.functionToastWidget(
            TextConstants.noDataFound, ColorConstants.toastErrorColor);
        setState(() {
          attendances = [];
        });
      } else if (response.data[ModelConstants.apiStatusCode] == 400) {
        ToastWidget.functionToastWidget(
            TextConstants.badRequest, ColorConstants.toastErrorColor);
      } else {
        ToastWidget.functionToastWidget(TextConstants.allAttendanceErrorToast,
            ColorConstants.toastErrorColor);
      }
      return response.data;
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Get All Attendances Function End ----------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBarWidget.functionAppBarInsideBackButton(
          TextConstants.detailsAttendancesAppBarTitleText, context),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: attendances.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    var attendanceId =
                        attendances[index][ModelConstants.attendanceId];
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              TextConstants.alertTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConstants.alertTitleFontSize,
                                  color: ColorConstants.primaryColor),
                            ),
                            content: const Text(
                              TextConstants.alertDeleteContent,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: SizeConstants.alertContentFontSize,
                                  color: ColorConstants.primaryColor),
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  TextConstants.alertButtonCancel,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConstants.alertButtonFontSize,
                                      color: ColorConstants.primaryColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  TextConstants.alertButtonConfirm,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConstants.alertButtonFontSize,
                                      color: ColorConstants.primaryColor),
                                ),
                                onPressed: () {
                                  AttendanceService().deleteAttendanceById(
                                      attendanceId, context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        SizeConstants.cardPaddingHorizontal,
                        SizeConstants.cardWithAppBarPaddingTop,
                        SizeConstants.cardPaddingHorizontal,
                        SizeConstants.cardPaddingBottom),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            SizeConstants.cardBorderRadius),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(
                                SizeConstants.cardPaddingAll),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  TextConstants.attendancesImageLink,
                                  height: SizeConstants.cardImageHeight,
                                  width: SizeConstants.cardImageWidth,
                                  fit: BoxFit.contain,
                                ),
                                Container(
                                    width: SizeConstants.cardContainerWidth),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          height: SizeConstants
                                              .cardContainerMinHeight),
                                      Text(
                                        (attendances[index][ModelConstants.user]
                                                [ModelConstants.username]
                                            .toString()),
                                        maxLines: 2,
                                        style: TextStyle(
                                          color:
                                              ColorConstants.cardValueTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConstants
                                              .cardAttributeTextFontSize,
                                        ),
                                      ),
                                      Container(
                                          height: SizeConstants
                                              .cardContainerMinHeight),
                                      Text(
                                        (attendances[index][ModelConstants.user]
                                                    [ModelConstants.company]
                                                [ModelConstants.companyName]
                                            .toString()),
                                        maxLines: 3,
                                        style: TextStyle(
                                          color:
                                              ColorConstants.cardValueTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConstants
                                              .cardAttributeTextFontSize,
                                        ),
                                      ),
                                      Container(
                                          height: SizeConstants
                                              .cardContainerMinHeight),
                                      Text(
                                        (attendances[index][ModelConstants.date]
                                            .toString()),
                                        maxLines: 1,
                                        style: TextStyle(
                                          color:
                                              ColorConstants.cardValueTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConstants
                                              .cardAttributeTextFontSize,
                                        ),
                                      ),
                                      Container(
                                          height: SizeConstants
                                              .cardContainerMinHeight),
                                      Text(
                                        (attendances[index]
                                                [ModelConstants.startTime]
                                            .toString()),
                                        maxLines: 1,
                                        style: TextStyle(
                                          color:
                                              ColorConstants.cardValueTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConstants
                                              .cardAttributeTextFontSize,
                                        ),
                                      ),
                                      Container(
                                          height: SizeConstants
                                              .cardContainerMinHeight),
                                      Text(
                                        (attendances[index]
                                                    [ModelConstants.endTime]) !=
                                                null
                                            ? (attendances[index]
                                                    [ModelConstants.endTime]
                                                .toString())
                                            : TextConstants.notYetRecordedText,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color:
                                              ColorConstants.cardValueTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConstants
                                              .cardAttributeTextFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
