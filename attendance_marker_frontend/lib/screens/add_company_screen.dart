import 'dart:developer';

import 'package:attendance_marker_frontend/utils/variables/color_palette.dart';
import 'package:attendance_marker_frontend/utils/variables/size_values.dart';
import 'package:attendance_marker_frontend/utils/widgets/form_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/company_service.dart';
import '../services/validator_service.dart';
import '../utils/variables/icon_palette.dart';
import '../utils/variables/text_values.dart';
import '../utils/widgets/user_app_bar_widget.dart';
import '../utils/widgets/navigational_drawer_widget.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  var formKey = GlobalKey<FormState>();
  var companyName = "";
  var companyLocation = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
        appBar: UserAppBarWidget.functionAppBarInside(
            TextValues.addCompanyAppBarTitleText, context),
        drawer:
            NavigationalDrawerWidget.functionUserNavigationalDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight / SizeValues.screenHeightDivideBy,
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: ColorPalette.signInScreenColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(SizeValues.signIgnImagePaddingAll),
                  child: Image.asset(TextValues.addCompanyImageLink),
                ),
              ),
              Container(
                color: ColorPalette.signInScreenColor,
                height: screenHeight *
                    SizeValues.screenHeightTop /
                    SizeValues.screenHeightDivideBy,
                width: screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          SizeValues.textFieldPaddingHorizontal,
                          SizeValues.textFieldWithAppBarPaddingTop,
                          SizeValues.textFieldPaddingHorizontal,
                          SizeValues.textFieldPaddingBottom),
                      child: FormTextFieldWidget.functionTextFormField(
                          companyName,
                          TextValues.companyName,
                          false,
                          const Icon(IconPalette.companyName),
                          ValidatorService.validateCompanyName),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          SizeValues.textFieldPaddingHorizontal,
                          SizeValues.textFieldPaddingTop,
                          SizeValues.textFieldPaddingHorizontal,
                          SizeValues.textFieldPaddingBottom),
                      child: FormTextFieldWidget.functionTextFormField(
                          companyLocation,
                          TextValues.companyLocation,
                          false,
                          const Icon(IconPalette.companyLocation),
                          ValidatorService.validateCompanyLocation),
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
                              CompanyService()
                                  .addCompany(companyName, companyLocation)
                                  .then((val) async {
                                if (val.data['success']) {
                                  Fluttertoast.showToast(
                                      msg: TextValues
                                          .addCompanyButtonSuccessToast,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          ColorPalette.toastSuccessColor,
                                      textColor: ColorPalette.toastTextColor,
                                      fontSize: SizeValues.toastFontSize);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          TextValues.addCompanyButtonErrorToast,
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
                            TextValues.addCompanyButtonText,
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
