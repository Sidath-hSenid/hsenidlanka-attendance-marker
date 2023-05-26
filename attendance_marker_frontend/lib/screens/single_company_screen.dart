import 'dart:developer';
import 'package:flutter/material.dart';

import '../services/company_service.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/icon_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/form_text_field_widget.dart';
import '../utils/widgets/user_app_bar_widget.dart';

class SingleCompanyScreen extends StatefulWidget {
  final String comId, comName, comLocation;
  const SingleCompanyScreen(
      {Key? key,
      required this.comId,
      required this.comName,
      required this.comLocation})
      : super(key: key);

  @override
  State<SingleCompanyScreen> createState() => _SingleCompanyScreenState();
}

class _SingleCompanyScreenState extends State<SingleCompanyScreen> {
  bool isLoading = false;

  var formKey = GlobalKey<FormState>();
  var companyId = "", companyName = "", companyLocation = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      companyId = widget.comId;
      companyName = widget.comName;
      companyLocation = widget.comLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
        appBar:
            UserAppBarWidget.functionAppBarInsideBackButtonWithDeleteCompany(
                TextConstants.detailsCompanyAppBarTitleText,
                companyId,
                context),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: screenHeight / SizeConstants.screenHeightDivideBy,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        color: ColorConstants.signInScreenColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: SizeConstants.signIgnImagePaddingAll,
                            right: SizeConstants.signIgnImagePaddingAll,
                            top: SizeConstants.signIgnImagePaddingAll),
                        child: Image.asset(TextConstants.addCompanyImageLink),
                      ),
                    ),
                    Container(
                      color: ColorConstants.signInScreenColor,
                      height: screenHeight *
                          SizeConstants.screenHeightTop /
                          SizeConstants.screenHeightDivideBy,
                      width: screenWidth,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldWithAppBarPaddingTop,
                                  SizeConstants.textFieldPaddingHorizontal,
                                  SizeConstants.textFieldPaddingBottom),
                              child: FormTextFieldWidget.functionTextFormField(
                                  false,
                                  TextEditingController(text: companyId),
                                  (value) {
                                    companyId = value;
                                  },
                                  TextConstants.companyId,
                                  false,
                                  const Icon(IconConstants.companyId),
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
                                  TextEditingController(text: companyName),
                                  (value) {
                                    companyName = value;
                                  },
                                  TextConstants.companyName,
                                  false,
                                  const Icon(IconConstants.companyName),
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
                                  TextEditingController(text: companyLocation),
                                  (value) {
                                    companyLocation = value;
                                  },
                                  TextConstants.companyLocation,
                                  false,
                                  const Icon(IconConstants.companyLocation),
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
                                    SizeConstants.buttonPaddingHorizontal,
                                    SizeConstants.buttonPaddingTop,
                                    SizeConstants.buttonPaddingHorizontal,
                                    SizeConstants.buttonPaddingBottom),
                                child: TextButton(
                                  style: ButtonStyle(
                                    fixedSize: MaterialStatePropertyAll(Size(
                                        screenWidth,
                                        screenHeight /
                                            SizeConstants.buttonHeight)),
                                    backgroundColor: ColorConstants.buttonColor,
                                    foregroundColor:
                                        ColorConstants.buttonTextColor,
                                    shadowColor:
                                        ColorConstants.buttonShadowColor,
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
                                                    color: ColorConstants
                                                        .primaryColor),
                                              ),
                                              content: const Text(
                                                TextConstants
                                                    .alertUpdateContent,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: SizeConstants
                                                        .alertContentFontSize,
                                                    color: ColorConstants
                                                        .primaryColor),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text(
                                                    TextConstants
                                                        .alertButtonCancel,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                    TextConstants
                                                        .alertButtonConfirm,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: SizeConstants
                                                            .alertButtonFontSize,
                                                        color: ColorConstants
                                                            .primaryColor),
                                                  ),
                                                  onPressed: () {
                                                    CompanyService()
                                                        .updateCompanyById(
                                                            companyId,
                                                            companyName,
                                                            companyLocation,
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
                                    TextConstants.updateCompanyButtonText,
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
