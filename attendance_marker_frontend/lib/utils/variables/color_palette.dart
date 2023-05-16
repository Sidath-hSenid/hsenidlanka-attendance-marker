import 'package:flutter/material.dart';

class ColorPalette {
  // Aplication Colors
  static const MaterialColor primaryColor = Colors.green;

  // Text form field Colors
  static const Color textColor = Colors.black;
  static const Color textFieldColor = Colors.green;
  static Color fillColor = Colors.green.shade50;
  static const Color focusBorder = Colors.green;
  static const Color errorBorder = Colors.red;
  static const Color enabledColor = Colors.transparent;
  static const Color textFieldIcon = Colors.green;

  // Button Colors
  static MaterialStateProperty<Color?> buttonColor =
      MaterialStateProperty.all<Color>(Colors.green);
  static MaterialStateProperty<Color?> buttonTextColor =
      MaterialStateProperty.all<Color>(Colors.white);
  static MaterialStateProperty<Color?> buttonShadowColor =
      MaterialStateProperty.all<Color>(Colors.grey);

  // Toast Colors
  static const Color toastSuccessColor = Colors.green;
  static const Color toastErrorColor = Colors.red;
  static const Color toastTextColor = Colors.white;

  // App Bar Colors
  static const Color appBarTitleText = Colors.white;
  static const Color appBarIconColor = Colors.white;

  // Link Colors
  static const Color forgotPasswordLinkText = Colors.green;
  static const Color validateOTPLinkText = Colors.green;

  // Title Colors
  static const Color titleText = Colors.green;

  // Screen Colors
  static const Color signInScreenColor = Colors.white;

}
