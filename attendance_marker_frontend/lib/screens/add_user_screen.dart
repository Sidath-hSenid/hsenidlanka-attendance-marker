// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:attendance_marker_frontend/utils/widgets/dropdown_list_widget.dart';
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
import '../utils/widgets/form_text_field_widget.dart';
import '../utils/widgets/toast_widget.dart';
import '../utils/widgets/user_app_bar_widget.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  bool isLoading = true;
  List companies = [];
  var company;

  var formKey = GlobalKey<FormState>();
  var username = "",
      email = "",
      password = "",
      companyId = "",
      companyName = "",
      companyLocation = "";

  @override
  void initState() {
    super.initState();
    getAllCompanies();
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
        body: SingleChildScrollView(
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
                        TextConstants.selectCompany,
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
                                fontSize: SizeConstants.textFieldFontSize,
                              ),
                            ),
                          );
                        }).toList(),
                      )),
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
                          SizeConstants.buttonPaddingHorizontal,
                          SizeConstants.buttonPaddingTop,
                          SizeConstants.buttonPaddingHorizontal,
                          SizeConstants.buttonPaddingBottom),
                      child: TextButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(screenWidth,
                              screenHeight / SizeConstants.buttonHeight)),
                          backgroundColor: ColorConstants.buttonColor,
                          foregroundColor: ColorConstants.buttonTextColor,
                          shadowColor: ColorConstants.buttonShadowColor,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            UserService().addUser(
                                username, email, password, company, context);
                          } else {
                            log(TextConstants.buttonLogError);
                          }
                        },
                        child: const Text(
                          TextConstants.addUserButtonText,
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
