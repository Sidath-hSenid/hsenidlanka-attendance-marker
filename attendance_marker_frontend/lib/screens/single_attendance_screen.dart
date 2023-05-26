import 'dart:developer';

import 'package:attendance_marker_frontend/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/constants/color_constants.dart';
import '../utils/constants/icon_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/form_text_field_widget.dart';
import '../utils/widgets/user_app_bar_widget.dart';

class SingleAttendanceScreen extends StatefulWidget {
  final String attId,
      attDate,
      attStartTime,
      attEndTime,
      attUsername,
      attCompanyName,
      attCompanyLocation;
  const SingleAttendanceScreen(
      {Key? key,
      required this.attId,
      required this.attDate,
      required this.attStartTime,
      required this.attEndTime,
      required this.attUsername,
      required this.attCompanyName,
      required this.attCompanyLocation})
      : super(key: key);

  @override
  State<SingleAttendanceScreen> createState() => _SingleAttendanceScreenState();
}

class _SingleAttendanceScreenState extends State<SingleAttendanceScreen> {
  bool isLoading = false;

  var formKey = GlobalKey<FormState>();
  var attendanceId = "",
      attendanceDate = "",
      attendanceStartTime = "",
      attendanceEndTime = "",
      attendanceUsername = "",
      attendanceCompanyName = "",
      attendanceCompanyLocation = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      attendanceId = widget.attId;
      attendanceDate = widget.attDate;
      attendanceStartTime = widget.attStartTime;
      attendanceEndTime = widget.attEndTime;
      attendanceUsername = widget.attUsername;
      attendanceCompanyName = widget.attCompanyName;
      attendanceCompanyLocation = widget.attCompanyLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
        appBar:
            UserAppBarWidget.functionAppBarInsideBackButtonWithDeleteAttendance(
                TextConstants.detailsAttendanceAppBarTitleText,
                attendanceId,
                context),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: screenHeight / SizeConstants.screenHeightDivideBy,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        color: ColorConstants.signInScreenColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: SizeConstants.signIgnImagePaddingAll,
                            right: SizeConstants.signIgnImagePaddingAll,
                            top: SizeConstants.signIgnImagePaddingAll),
                        child:
                            Image.asset(TextConstants.addAttendanceImageLink),
                      ),
                    ),
                    Container(
                      color: ColorConstants.signInScreenColor,
                      height: screenHeight *
                          SizeConstants.screenHeightForAttendanceUpdate,
                      width: screenWidth,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldWithAppBarPaddingTop,
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingBottom),
                              child: FormTextFieldWidget.functionTextFormField(
                                  false,
                                  TextEditingController(text: attendanceId),
                                  (value) {
                                    attendanceId = value;
                                  },
                                  TextConstants.attendanceId,
                                  false,
                                  const Icon(IconConstants.attendanceId),
                                  (value) {
                                    if (value!.isEmpty) {
                                      return TextConstants.emptyValueValidation;
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldWithAppBarPaddingTop,
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingBottom),
                              child: FormTextFieldWidget.functionTextFormField(
                                  false,
                                  TextEditingController(text: attendanceDate),
                                  (value) {
                                    attendanceDate = value;
                                  },
                                  TextConstants.attendanceDate,
                                  false,
                                  const Icon(IconConstants.attendanceDate),
                                  (value) {
                                    if (value!.isEmpty) {
                                      return TextConstants.emptyValueValidation;
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingTop,
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingBottom),
                              child: FormTextFieldWidget.functionTextFormField(
                                  true,
                                  TextEditingController(
                                      text: attendanceStartTime),
                                  (value) {
                                    attendanceStartTime = value;
                                  },
                                  TextConstants.attendanceStartTime,
                                  false,
                                  const Icon(IconConstants.attendanceStartTime),
                                  (value) {
                                    if (value!.isEmpty) {
                                      return TextConstants.emptyValueValidation;
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingTop,
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingBottom),
                              child: FormTextFieldWidget.functionTextFormField(
                                  true,
                                  TextEditingController(
                                      text: attendanceEndTime),
                                  (value) {
                                    attendanceEndTime = value;
                                  },
                                  TextConstants.attendanceEndTime,
                                  false,
                                  const Icon(IconConstants.attendanceEndTime),
                                  (value) {
                                    if (value!.isEmpty) {
                                      return TextConstants.emptyValueValidation;
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldWithAppBarPaddingTop,
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingBottom),
                              child: FormTextFieldWidget.functionTextFormField(
                                  false,
                                  TextEditingController(
                                      text: attendanceUsername),
                                  (value) {
                                    attendanceUsername = value;
                                  },
                                  TextConstants.attendanceUsername,
                                  false,
                                  const Icon(IconConstants.attendanceUsername),
                                  (value) {
                                    if (value!.isEmpty) {
                                      return TextConstants.emptyValueValidation;
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldWithAppBarPaddingTop,
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingBottom),
                              child: FormTextFieldWidget.functionTextFormField(
                                  false,
                                  TextEditingController(
                                      text: attendanceCompanyName),
                                  (value) {
                                    attendanceCompanyName = value;
                                  },
                                  TextConstants.attendanceCompanyName,
                                  false,
                                  const Icon(
                                      IconConstants.attendanceCompanyName),
                                  (value) {
                                    if (value!.isEmpty) {
                                      return TextConstants.emptyValueValidation;
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldWithAppBarPaddingTop,
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingBottom),
                              child: FormTextFieldWidget.functionTextFormField(
                                  false,
                                  TextEditingController(
                                      text: attendanceCompanyLocation),
                                  (value) {
                                    attendanceCompanyLocation = value;
                                  },
                                  TextConstants.attendanceCompanyLocation,
                                  false,
                                  const Icon(
                                      IconConstants.attendanceCompanyLocation),
                                  (value) {
                                    if (value!.isEmpty) {
                                      return TextConstants.emptyValueValidation;
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    SizeConstants.buttonPaddingHorizontal,
                                    SizeConstants.buttonPaddingTop,
                                    SizeConstants.buttonPaddingHorizontal,
                                    SizeConstants.buttonPaddingBottom),
                                child: TextButton(
                                  style: ButtonStyle(
                                    fixedSize: MaterialStatePropertyAll(Size(
                                        screenWidth,
                                        screenHeight /
                                            SizeConstants.buttonHeight)),
                                    backgroundColor: ColorConstants.buttonColor,
                                    foregroundColor:
                                        ColorConstants.buttonTextColor,
                                    shadowColor:
                                        ColorConstants.buttonShadowColor,
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      AttendanceService().updateAttendanceById(
                                          attendanceId,
                                          attendanceStartTime,
                                          attendanceEndTime,
                                          context);
                                    } else {
                                      log(TextConstants.buttonLogError);
                                    }
                                  },
                                  child: const Text(
                                    TextConstants.updateAttendanceButtonText,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConstants.buttonFontSize,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
