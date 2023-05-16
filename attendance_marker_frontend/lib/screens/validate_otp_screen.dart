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

class ValidateOTPScreen extends StatefulWidget {
  const ValidateOTPScreen({super.key});

  @override
  State<ValidateOTPScreen> createState() => _ValidateOTPScreenState();
}

class _ValidateOTPScreenState extends State<ValidateOTPScreen> {
  final formKey = GlobalKey<FormState>();
  var otp = "";

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
                        TextValues.validateOTPTitleText,
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
                          otp,
                          TextValues.otp,
                          false,
                          const Icon(IconPalette.otp),
                          ValidatorService.validateOTP),
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const ForgotPasswordScreen()));
                            },
                            child: const Text(
                              TextValues.validateOTPLink,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: SizeValues.validateOTPLinkFontSize,
                                  color: ColorPalette.validateOTPLinkText),
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
                              UserService().validateOTP(otp).then((val) async {
                                if (val.data['success']) {
                                  Fluttertoast.showToast(
                                      msg: TextValues
                                          .validateOTPButtonSuccessToast,
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
                                          .validateOTPButtonErrorToast,
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
                            TextValues.validateOTPButtonText,
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
