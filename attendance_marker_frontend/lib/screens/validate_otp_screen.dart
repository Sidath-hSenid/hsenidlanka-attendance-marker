import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/user_service.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/icon_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';
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
                            SizeConstants.titleTextPaddingTop,
                            SizeConstants.titleTextPaddingHorizontal,
                            SizeConstants.titleTextPaddingBottom),
                        child: Text(
                          TextConstants.validateOTPTitleText,
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
                            TextEditingController(text: otp),
                            (value) {
                              otp = value;
                            },
                            TextConstants.otp,
                            false,
                            const Icon(IconConstants.otp),
                            (value) {
                              if (value!.isEmpty) {
                                return TextConstants.emptyValueValidation;
                              } else if (value.length < 4) {
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const ForgotPasswordScreen()));
                              },
                              child: const Text(
                                TextConstants.validateOTPLink,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                        SizeConstants.validateOTPLinkFontSize,
                                    color: ColorConstants.validateOTPLinkText),
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
                                    .validateOTP(otp)
                                    .then((val) async {
                                  if (val.data['success']) {
                                    Fluttertoast.showToast(
                                        msg: TextConstants
                                            .validateOTPButtonSuccessToast,
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
                                            .validateOTPButtonErrorToast,
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
                              TextConstants.validateOTPButtonText,
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
