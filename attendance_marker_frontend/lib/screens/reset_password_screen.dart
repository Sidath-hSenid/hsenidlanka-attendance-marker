import 'dart:developer';

import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/size_constants.dart';
import 'package:attendance_marker_frontend/utils/widgets/form_text_field_widget.dart';
import 'package:flutter/material.dart';

import '../services/user_service.dart';
import '../utils/constants/icon_constants.dart';
import '../utils/constants/text_constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  var password = "", confirmPassword = "", username = "", email = "";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: ColorConstants.primaryColor,
                height: screenHeight / SizeConstants.screenHeightDivideBy,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(
                      SizeConstants.signIgnImagePaddingAll),
                  child: Image.asset(TextConstants.appLogoImageLink),
                ),
              ),
              Form(
                key: formKey,
                child: Container(
                  decoration: const BoxDecoration(
                      color: ColorConstants.signInScreenColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              SizeConstants.signInScreenTopLeftRadius))),
                  height:
                      screenHeight * 1.5 / SizeConstants.screenHeightDivideBy,
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(
                            SizeConstants.titleTextPaddingHorizontal,
                            SizeConstants.textFieldWithAppBarPaddingTop,
                            SizeConstants.titleTextPaddingHorizontal,
                            SizeConstants.titleTextPaddingBottom),
                        child: Text(
                          TextConstants.resetPasswordTitleText,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConstants.titleTextFontSize,
                              color: ColorConstants.titleText),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            SizeConstants.textFieldPaddingHorizontal,
                            SizeConstants.textFieldWithAppBarPaddingTop,
                            SizeConstants.textFieldPaddingHorizontal,
                            SizeConstants.textFieldPaddingBottom),
                        child: FormTextFieldWidget.functionTextFormField(
                            true,
                            TextEditingController(text: username),
                            (value) {
                              username = value;
                            },
                            TextConstants.userName,
                            false,
                            const Icon(IconConstants.username),
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
                            true,
                            TextEditingController(text: email),
                            (value) {
                              email = value;
                            },
                            TextConstants.email,
                            false,
                            const Icon(IconConstants.email),
                            (value) {
                              if (value!.isEmpty) {
                                return TextConstants.emptyValueValidation;
                              } else if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return null;
                              } else {
                                return TextConstants.emailValidation;
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
                            TextEditingController(text: password),
                            (value) {
                              password = value;
                            },
                            TextConstants.password,
                            true,
                            const Icon(IconConstants.password),
                            (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value!.isEmpty) {
                                return TextConstants.emptyValueValidation;
                              } else if (!regex.hasMatch(value)) {
                                return TextConstants.passwordStrengthValidation;
                              } else if (value.length < 8) {
                                return TextConstants.passwordLengthValidation;
                              }
                              return null;
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
                            TextEditingController(text: confirmPassword),
                            (value) {
                              confirmPassword = value;
                            },
                            TextConstants.confirmPassword,
                            true,
                            const Icon(IconConstants.confirmPassword),
                            (value) {
                              if (value!.isEmpty) {
                                return TextConstants.emptyValueValidation;
                              } else if (value.length < 8) {
                                return TextConstants.passwordLengthValidation;
                              } else if (password != confirmPassword) {
                                return TextConstants.passwordMisMatchValidation;
                              }
                              return null;
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
                                  screenHeight / SizeConstants.buttonHeight)),
                              backgroundColor: ColorConstants.buttonColor,
                              foregroundColor: ColorConstants.buttonTextColor,
                              shadowColor: ColorConstants.buttonShadowColor,
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          TextConstants.alertTitle,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: SizeConstants
                                                  .alertTitleFontSize,
                                              color:
                                                  ColorConstants.primaryColor),
                                        ),
                                        content: const Text(
                                          TextConstants.alertResetPassword,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: SizeConstants
                                                  .alertContentFontSize,
                                              color:
                                                  ColorConstants.primaryColor),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              TextConstants.alertButtonCancel,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConstants
                                                      .alertButtonFontSize,
                                                  color: ColorConstants
                                                      .primaryColor),
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
                                                  fontSize: SizeConstants
                                                      .alertButtonFontSize,
                                                  color: ColorConstants
                                                      .primaryColor),
                                            ),
                                            onPressed: () {
                                              UserService().resetPassword(
                                                  username,
                                                  email,
                                                  password,
                                                  context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                log(TextConstants.buttonLogError);
                              }
                            },
                            child: const Text(
                              TextConstants.resetPasswordButtonText,
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
