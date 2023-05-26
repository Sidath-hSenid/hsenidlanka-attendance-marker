import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/company_model.dart';
import '../services/user_service.dart';
import '../utils/constants/backend_api_constants.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/icon_constants.dart';
import '../utils/constants/model_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/dropdown_list_widget.dart';
import '../utils/widgets/form_text_field_widget.dart';
import '../utils/widgets/toast_widget.dart';
import '../utils/widgets/user_app_bar_widget.dart';

class SingleUserScreen extends StatefulWidget {
  final useId, usename, useEmail, useCompany;
  const SingleUserScreen(
      {Key? key,
      required this.useId,
      required this.usename,
      required this.useEmail,
      required this.useCompany})
      : super(key: key);

  @override
  State<SingleUserScreen> createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {
  bool isLoading = false;
  List companies = [];
  var formKey = GlobalKey<FormState>();
  var userId, username, email;
  var company;

  @override
  void initState() {
    super.initState();
    getAllCompanies();
    setState(() {
      userId = widget.useId;
      username = widget.usename;
      email = widget.useEmail;
      company = widget.useCompany;
    });
  }

  // ---------------------------------------------- Get All Companies Function Start ----------------------------------------------

  CompanyModel? companyDataFromAPI;

  getAllCompanies() async {
    Dio dio = Dio();
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(ModelConstants.token);

    try {
      response = await dio.get(
        BackendAPIConstants.rootAPI + BackendAPIConstants.getAllCompaniesAPI,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {ModelConstants.auth: "Bearer $accessToken"},
        ),
      );

      if (response.statusCode == 200) {
        ToastWidget.functionToastWidget(TextConstants.allCompanySuccessToast,
            ColorConstants.toastSuccessColor);
        print((response.data).runtimeType);
        var items = response.data;
        setState(() {
          companies = items;
        });
        return companies;
      } else {
        setState(() {
          companies = [];
        });

        ToastWidget.functionToastWidget(
            TextConstants.allCompanyErrorToast, ColorConstants.toastErrorColor);
      }
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
      rethrow;
    }
  }

  // ---------------------------------------------- Get All Companies Function End ----------------------------------------------

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
        appBar: UserAppBarWidget.functionAppBarInsideBackButtonWithDeleteUser(
            TextConstants.detailsUserAppBarTitleText, userId, context),
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
                        child: Image.asset(TextConstants.addUserImageLink),
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
                                  TextEditingController(text: userId),
                                  (value) {
                                    userId = value;
                                  },
                                  TextConstants.userId,
                                  false,
                                  const Icon(IconConstants.userId),
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
                                    SizeConstants.textFieldWithAppBarPaddingTop,
                                    SizeConstants.textFieldPaddingHorizontal,
                                    SizeConstants.textFieldPaddingBottom),
                                child: DropdwonListWidget.functionDropdownList(
                                  const Icon(IconConstants.companyName),
                                  company[ModelConstants.companyName],
                                  (newVal) {
                                    setState(() {
                                      company = newVal!;
                                    });
                                  },
                                  (newVal) {
                                    if (newVal!.isEmpty) {
                                      return TextConstants.emptyValueValidation;
                                    } else {
                                      return null;
                                    }
                                  },
                                  companies.map((val) {
                                    return DropdownMenuItem(
                                      value: val,
                                      child: Text(
                                        val[ModelConstants.companyName],
                                        style: const TextStyle(
                                          color: ColorConstants.textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              SizeConstants.textFieldFontSize,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )),
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
                                                    UserService()
                                                        .updateUserById(
                                                            userId,
                                                            username,
                                                            email,
                                                            company,
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
                                    TextConstants.updateUserButtonText,
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
