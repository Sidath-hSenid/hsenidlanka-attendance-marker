import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/text_constants.dart';
import 'package:flutter/material.dart';

import '../constants/size_constants.dart';

class AlertDialogBox {
  static functionAlertConfirmOrCancel(contentTextValue, confirmValue, context) {
    return AlertDialog(
      title: const Text(
        TextConstants.alertTitle,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.alertTitleFontSize,
            color: ColorConstants.primaryColor),
      ),
      content: Text(
        contentTextValue,
        style: const TextStyle(
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
                fontSize: SizeConstants.alertButtonFontSize,
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
                fontSize: SizeConstants.alertButtonFontSize,
                color: ColorConstants.primaryColor),
          ),
          onPressed: () async {
            await confirmValue;
          },
        ),
      ],
    );
  }

  static functionAlertOk(contentTextValue, context) {
    return AlertDialog(
      title: const Text(
        TextConstants.alertTitle,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.alertTitleFontSize,
            color: ColorConstants.primaryColor),
      ),
      content: Text(
        contentTextValue,
        style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: SizeConstants.alertContentFontSize,
            color: ColorConstants.primaryColor),
      ),
      actions: [
        TextButton(
          child: const Text(
            TextConstants.alertButtonOk,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConstants.alertButtonFontSize,
                color: ColorConstants.primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
