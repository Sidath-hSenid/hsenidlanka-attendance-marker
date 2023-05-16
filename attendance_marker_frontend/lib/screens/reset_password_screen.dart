import 'dart:developer';

import 'package:attendance_marker_frontend/screens/forgot_password_screen.dart';
import 'package:attendance_marker_frontend/utils/variables/color_palette.dart';
import 'package:attendance_marker_frontend/utils/variables/size_values.dart';
import 'package:attendance_marker_frontend/utils/widgets/form_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_service.dart';
import '../services/validator_service.dart';
import '../utils/variables/icon_palette.dart';
import '../utils/variables/text_values.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  var password = "";
  var confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
        backgroundColor: ColorPalette.primaryColor,
        // appBar:
        //     AppBarWidget.functionAppBarNormal(TextValues.signInAppBarTitleText),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: ColorPalette.primaryColor,
                height: screenHeight / SizeValues.screenHeightDivideBy,
                width: screenWidth,
                child: Padding(
                  padding:
                      const EdgeInsets.all(SizeValues.signIgnImagePaddingAll),
                  child: Image.asset(TextValues.appLogoImageLink),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: ColorPalette.signInScreenColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            SizeValues.signInScreenTopLeftRadius))),
                height: screenHeight * SizeValues.screenHeightTop / SizeValues.screenHeightDivideBy,
                width: screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeValues.titleTextPaddingHorizontal,
                          SizeValues.titleTextPaddingTop,
                          SizeValues.titleTextPaddingHorizontal,
                          SizeValues.titleTextPaddingBottom),
                      child: Text(
                        TextValues.resetPasswordTitleText,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeValues.titleTextFontSize,
                            color: ColorPalette.titleText),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          SizeValues.textFieldPaddingHorizontal,
                          SizeValues.textFieldPaddingTop,
                          SizeValues.textFieldPaddingHorizontal,
                          SizeValues.textFieldPaddingBottom),
                      child: FormTextFieldWidget.functionTextFormField(
                          password,
                          TextValues.password,
                          true,
                          const Icon(IconPalette.password),
                          ValidatorService.validatePassword),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          SizeValues.textFieldPaddingHorizontal,
                          SizeValues.textFieldPaddingTop,
                          SizeValues.textFieldPaddingHorizontal,
                          SizeValues.textFieldPaddingBottom),
                      child: FormTextFieldWidget.functionTextFormField(
                          confirmPassword,
                          TextValues.consfirmPasword,
                          true,
                          const Icon(IconPalette.confirmPassword),
                          ValidatorService.validateConfirmPassword),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(
                            SizeValues.buttonPaddingHorizontal,
                            SizeValues.buttonPaddingTop,
                            SizeValues.buttonPaddingHorizontal,
                            SizeValues.buttonPaddingBottom),
                        child: TextButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(
                                screenWidth,
                                screenHeight / SizeValues.buttonHeight)),
                            backgroundColor: ColorPalette.buttonColor,
                            foregroundColor: ColorPalette.buttonTextColor,
                            shadowColor: ColorPalette.buttonShadowColor,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (password == confirmPassword) {
                                UserService()
                                    .resetPassword(password)
                                    .then((val) async {
                                  if (val.data['success']) {
                                    Fluttertoast.showToast(
                                        msg: TextValues
                                            .resetPasswordButtonSuccessToast,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            ColorPalette.toastSuccessColor,
                                        textColor: ColorPalette.toastTextColor,
                                        fontSize: SizeValues.toastFontSize);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: TextValues
                                            .resetPasswordButtonErrorToast,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            ColorPalette.toastErrorColor,
                                        textColor: ColorPalette.toastTextColor,
                                        fontSize: SizeValues.toastFontSize);
                                  }
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: TextValues.passwordMisMatchValidation,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        ColorPalette.toastErrorColor,
                                    textColor: ColorPalette.toastTextColor,
                                    fontSize: SizeValues.toastFontSize);
                              }
                            } else {
                              log(TextValues.buttonLogError);
                            }
                          },
                          child: const Text(
                            TextValues.resetPasswordButtonText,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeValues.buttonFontSize,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
