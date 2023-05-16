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
import '../utils/widgets/user_app_bar_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  var username = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
        backgroundColor: ColorPalette.primaryColor,
        // appBar:
        //     AppBarWidget.functionAppBarBackButton(TextValues.addCompanyAppBarTitleText, context),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeValues.titleTextPaddingHorizontal,
                          SizeValues.textFieldWithAppBarPaddingTop,
                          SizeValues.titleTextPaddingHorizontal,
                          SizeValues.titleTextPaddingBottom),
                      child: Text(
                        TextValues.signInTitleText,
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
                          username,
                          TextValues.userName,
                          false,
                          const Icon(IconPalette.username),
                          ValidatorService.validateUsername),
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
                          SizeValues.rightSideTextPaddingRight,
                          SizeValues.rightSideTextPaddingTop,
                          SizeValues.rightSideTextPaddingRight,
                          SizeValues.rightSideTextPaddingBottom),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen()));
                            },
                            child: const Text(
                              TextValues.forgotPasswordLink,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize:
                                      SizeValues.forgotPasswordLinkFontSize,
                                  color: ColorPalette.forgotPasswordLinkText),
                            ),
                          )
                        ],
                      ),
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
                              UserService()
                                  .login(username, password)
                                  .then((val) async {
                                if (val.data['success']) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('username', username);

                                  Fluttertoast.showToast(
                                      msg: TextValues.signInButtonSuccessToast,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          ColorPalette.toastSuccessColor,
                                      textColor: ColorPalette.toastTextColor,
                                      fontSize: SizeValues.toastFontSize);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: TextValues.signInButtonErrorToast,
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
                              log(TextValues.buttonLogError);
                            }
                          },
                          child: const Text(
                            TextValues.signInButtonText,
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
