import 'dart:developer';

import 'package:attendance_marker_frontend/services/user_service.dart';
import 'package:attendance_marker_frontend/utils/variables/color_palette.dart';
import 'package:attendance_marker_frontend/utils/variables/size_values.dart';
import 'package:attendance_marker_frontend/utils/variables/text_values.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonFunctionService {

  static loginTextButtonFunction (var formKeyValue, var emailValue, var passwordValue){
    if (formKeyValue.currentState.validate()) {
      UserService().login(emailValue, passwordValue).then((val) async {
        if (val.data['success']) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', emailValue);

          Fluttertoast.showToast(
              msg: TextValues.signInButtonSuccessToast,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorPalette.toastSuccessColor,
              textColor: ColorPalette.toastTextColor,
              fontSize: SizeValues.toastFontSize);
        } else {
          Fluttertoast.showToast(
              msg: TextValues.signInButtonErrorToast,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorPalette.toastErrorColor,
              textColor: ColorPalette.toastTextColor,
              fontSize: SizeValues.toastFontSize);
        }
      });
    } else {
      log("Error");
    }
  }
}
