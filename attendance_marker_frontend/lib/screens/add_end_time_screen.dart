import 'package:flutter/material.dart';

import '../services/attendance_service.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';

class AddEndTimeScreen extends StatefulWidget {
  const AddEndTimeScreen({super.key});

  @override
  State<AddEndTimeScreen> createState() => _AddEndTimeScreenState();
}

class _AddEndTimeScreenState extends State<AddEndTimeScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizeConstants.signIgnImagePaddingAll),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                TextConstants.addEndTimeText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstants.infoTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: SizeConstants.infoTextFontSize,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: SizeConstants.fingerPrintMarginTop),
                color: ColorConstants.enabledColor,
                child: GestureDetector(
                  onTap: () {
                    AttendanceService().updateDayAttendanceEndTimeById(context);
                  },
                  child: SizedBox(
                    child: Image.asset(
                      TextConstants.fingerPrintImageLink,
                      width: screenWidth / SizeConstants.fingerPrintDivideBy,
                      height: screenHeight / SizeConstants.fingerPrintDivideBy,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
