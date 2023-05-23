import 'package:fluttertoast/fluttertoast.dart';

import '../constants/color_constants.dart';
import '../constants/size_constants.dart';

class ToastWidget {
  static functionToastWidget(var msgValue, var backgroundColorValue) {
    return Fluttertoast.showToast(
        msg: msgValue,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColorValue,
        textColor: ColorConstants.toastTextColor,
        fontSize: SizeConstants.toastFontSize);
  }
}
