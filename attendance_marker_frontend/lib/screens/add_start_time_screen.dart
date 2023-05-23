import 'package:flutter/material.dart';

import '../services/attendance_service.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/user_app_bar_widget.dart';

class AddStartTimeScreen extends StatefulWidget {
  const AddStartTimeScreen({super.key});

  @override
  State<AddStartTimeScreen> createState() => _AddStartTimeScreenState();
}

class _AddStartTimeScreenState extends State<AddStartTimeScreen> {
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
              padding:
                  const EdgeInsets.all(SizeConstants.signIgnImagePaddingAll),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    TextConstants.addStartTimeText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstants.infoTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConstants.infoTextFontSize,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: SizeConstants.fingerPrintMarginTop),
                    color: ColorConstants.enabledColor,
                    child: GestureDetector(
                      onTap: () {
                        AttendanceService().addAttendance(context);
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
