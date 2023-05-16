import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_service.dart';
import '../services/validator_service.dart';
import '../utils/variables/color_palette.dart';
import '../utils/variables/icon_palette.dart';
import '../utils/variables/size_values.dart';
import '../utils/variables/text_values.dart';
import '../utils/widgets/user_app_bar_widget.dart';
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
                          SizeValues.titleTextPaddingTop,
                          SizeValues.titleTextPaddingHorizontal,
                          SizeValues.titleTextPaddingBottom),
                      child: Text(
                        TextValues.forgotPasswordTitleText,
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
                          email,
                          TextValues.email,
                          false,
                          const Icon(IconPalette.email),
                          ValidatorService.validateEmail),
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
                                  .forgotPassword(email)
                                  .then((val) async {
                                if (val.data['success']) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('email', email);

                                  Fluttertoast.showToast(
                                      msg: TextValues
                                          .forgotPasswordButtonSuccessToast,
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
                                          .forgotPasswordButtonErrorToast,
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
                            TextValues.forgotPasswordButtonText,
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
