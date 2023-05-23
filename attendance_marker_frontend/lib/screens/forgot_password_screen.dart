import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_service.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/icon_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/form_text_field_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  var email = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        // appBar:
        //     AppBarWidget.functionAppBarBackButton(TextValues.addCompanyAppBarTitleText, context),
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
                            SizeConstants.titleTextPaddingTop,
                            SizeConstants.titleTextPaddingHorizontal,
                            SizeConstants.titleTextPaddingBottom),
                        child: Text(
                          TextConstants.forgotPasswordTitleText,
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
                                    .forgotPassword(email)
                                    .then((val) async {
                                  if (val.data['success']) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('email', email);

                                    Fluttertoast.showToast(
                                        msg: TextConstants
                                            .forgotPasswordButtonSuccessToast,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            ColorConstants.toastSuccessColor,
                                        textColor:
                                            ColorConstants.toastTextColor,
                                        fontSize: SizeConstants.toastFontSize);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: TextConstants
                                            .forgotPasswordButtonErrorToast,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            ColorConstants.toastErrorColor,
                                        textColor:
                                            ColorConstants.toastTextColor,
                                        fontSize: SizeConstants.toastFontSize);
                                  }
                                });
                              } else {
                                log(TextConstants.buttonLogError);
                              }
                            },
                            child: const Text(
                              TextConstants.forgotPasswordButtonText,
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
