import 'package:flutter/material.dart';

import '../services/attendance_service.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';

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
          padding: const EdgeInsets.all(SizeConstants.signIgnImagePaddingAll),
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
                margin: const EdgeInsets.only(
                    top: SizeConstants.fingerPrintMarginTop),
                color: ColorConstants.enabledColor,
                child: GestureDetector(
                  onTap: () {
                    AttendanceService().addAttendance(context);
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         title: const Text(
                    //           TextConstants.alertTitle,
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: SizeConstants.alertTitleFontSize,
                    //               color: ColorConstants.primaryColor),
                    //         ),
                    //         content: const Text(
                    //           TextConstants.alertAddStartTime,
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.normal,
                    //               fontSize: SizeConstants.alertContentFontSize,
                    //               color: ColorConstants.primaryColor),
                    //         ),
                    //         actions: [
                    //           TextButton(
                    //             child: const Text(
                    //               TextConstants.alertButtonCancel,
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize:
                    //                       SizeConstants.alertButtonFontSize,
                    //                   color: ColorConstants.primaryColor),
                    //             ),
                    //             onPressed: () {
                    //               Navigator.of(context).pop();
                    //             },
                    //           ),
                    //           TextButton(
                    //             child: const Text(
                    //               TextConstants.alertButtonConfirm,
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize:
                    //                       SizeConstants.alertButtonFontSize,
                    //                   color: ColorConstants.primaryColor),
                    //             ),
                    //             onPressed: () {
                    //               AttendanceService().addAttendance(context);
                    //             },
                    //           ),
                    //         ],
                    //       );
                    //     });
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
