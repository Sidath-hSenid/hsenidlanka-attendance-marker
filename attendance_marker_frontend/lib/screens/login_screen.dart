import 'dart:developer';

import 'package:attendance_marker_frontend/screens/reset_password_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/size_constants.dart';
import 'package:attendance_marker_frontend/utils/widgets/form_text_field_widget.dart';
import 'package:flutter/material.dart';

import '../services/user_service.dart';
import '../utils/constants/icon_constants.dart';
import '../utils/constants/text_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  var username = "", password = "";

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
                  height: screenHeight *
                      SizeConstants.screenHeightTop /
                      SizeConstants.screenHeightDivideBy,
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
                          TextConstants.signInTitleText,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConstants.titleTextFontSize,
                              color: ColorConstants.titleText),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            SizeConstants.textFieldPaddingHorizontal,
                            SizeConstants.textFieldPaddingTop,
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
                              if (value!.isEmpty) {
                                return TextConstants.emptyValueValidation;
                              } else if (value.length < 6) {
                                return TextConstants.passwordLengthValidation;
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            SizeConstants.rightSideTextPaddingRight,
                            SizeConstants.rightSideTextPaddingTop,
                            SizeConstants.rightSideTextPaddingRight,
                            SizeConstants.rightSideTextPaddingBottom),
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
                                            const ResetPasswordScreen()));
                              },
                              child: const Text(
                                TextConstants.resetPasswordLink,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: SizeConstants
                                        .forgotPasswordLinkFontSize,
                                    color:
                                        ColorConstants.forgotPasswordLinkText),
                              ),
                            )
                          ],
                        ),
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
                                UserService()
                                    .login(username, password, context);
                              } else {
                                log(TextConstants.buttonLogError);
                              }
                            },
                            child: const Text(
                              TextConstants.signInButtonText,
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
