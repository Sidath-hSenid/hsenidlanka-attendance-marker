import 'package:attendance_marker_frontend/utils/constants/size_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/backend_api_constants.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/model_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/toast_widget.dart';

class UserViewAttendancesScreen extends StatefulWidget {
  const UserViewAttendancesScreen({super.key});

  @override
  State<UserViewAttendancesScreen> createState() =>
      _UserViewAttendancesScreenState();
}

class _UserViewAttendancesScreenState extends State<UserViewAttendancesScreen> {
  bool isLoading = true;
  List attendances = [];
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getAllAttendancesByUser();
  }

  // ---------------------------------------------- Get All Attendances Function Start ----------------------------------------------

  getAllAttendancesByUser() async {
    Dio dio = Dio();
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);
    var userId = prefs.getString(ModelConstants.sharedUserId).toString();

    try {
      response = await dio.get(
        BackendAPIConstants.rootAPI +
            BackendAPIConstants.getAttendanceByUserIdAPI +
            userId,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      if (response.data[ModelConstants.apiStatusCode] == 200) {
        var items = response.data[ModelConstants.apiAttendanceResponseList];
        setState(() {
          attendances = items;
        });
        isLoading = false;
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
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: attendances.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(SizeConstants.cardPaddingAll),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            SizeConstants.userCardBorderRadius),
                        border: Border.all(
                          color: attendances[index][ModelConstants.halfDay] ==
                                  ModelConstants.halfDayFlaseBool
                              ? ColorConstants.primaryColor
                              : ColorConstants.errorBorder,
                          width: 5,
                        )),
                    width: screenWidth - SizeConstants.cardWidthReduce,
                    child: Card(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              TextConstants.attendancesImageLink,
                              height: screenHeight / 2,
                              width: screenWidth / 2,
                              fit: BoxFit.contain,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    SizeConstants.cardPaddingAll),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: SizeConstants
                                                    .cardContainerMaxHeight),
                                            Text(
                                              TextConstants.cardAttendanceDate,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .userCardAttributeTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConstants
                                                    .userCardAttributeTextFontSize,
                                              ),
                                            ),
                                            Container(
                                                height: SizeConstants
                                                    .cardContainerMaxHeight),
                                            Text(
                                              (attendances[index]
                                                      [ModelConstants.date]
                                                  .toString()),
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .userCardValueTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConstants
                                                    .userCardValueTextFontSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: SizeConstants
                                                    .cardContainerMaxHeight),
                                            Text(
                                              TextConstants
                                                  .cardAttendanceWorkedHours,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .userCardAttributeTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConstants
                                                    .userCardAttributeTextFontSize,
                                              ),
                                            ),
                                            Container(
                                                height: SizeConstants
                                                    .cardContainerMaxHeight),
                                            Text(
                                              (attendances[index][ModelConstants
                                                      .workedHours]
                                                  .toString()),
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .userCardValueTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConstants
                                                    .userCardValueTextFontSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: SizeConstants
                                                    .cardContainerMaxHeight),
                                            Text(
                                              TextConstants
                                                  .cardAttendanceStartTime,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .userCardAttributeTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConstants
                                                    .userCardAttributeTextFontSize,
                                              ),
                                            ),
                                            Container(
                                                height: SizeConstants
                                                    .cardContainerMaxHeight),
                                            Text(
                                              (attendances[index]
                                                      [ModelConstants.startTime]
                                                  .toString()),
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .userCardValueTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConstants
                                                    .userCardValueTextFontSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: SizeConstants
                                                    .cardContainerMaxHeight),
                                            Text(
                                              TextConstants
                                                  .cardAttendanceEndTime,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .userCardAttributeTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConstants
                                                    .userCardAttributeTextFontSize,
                                              ),
                                            ),
                                            Container(
                                                height: SizeConstants
                                                    .cardContainerMaxHeight),
                                            Text(
                                              (attendances[index][ModelConstants
                                                          .endTime]) !=
                                                      null
                                                  ? (attendances[index][
                                                          ModelConstants
                                                              .endTime]
                                                      .toString())
                                                  : TextConstants
                                                      .notYetRecordedText,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .userCardValueTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConstants
                                                    .userCardValueTextFontSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
