import 'package:attendance_marker_frontend/screens/single_company_screen.dart';
import 'package:attendance_marker_frontend/services/company_service.dart';
import 'package:attendance_marker_frontend/utils/constants/size_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/backend_api_constants.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/model_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/toast_widget.dart';

class AllCompaniesScreen extends StatefulWidget {
  const AllCompaniesScreen({super.key});

  @override
  State<AllCompaniesScreen> createState() => _AllCompaniesScreenState();
}

class _AllCompaniesScreenState extends State<AllCompaniesScreen> {
  bool isLoading = true;
  List companies = [];
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getAllCompanies();
  }

  // ---------------------------------------------- Get All Companies Function Start ----------------------------------------------

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

      if (response.data[ModelConstants.apiStatusCode] == 200) {
        var items = response.data[ModelConstants.apiCompanyResponseList];
        setState(() {
          companies = items;
        });
        isLoading = false;
      } else if (response.data[ModelConstants.apiStatusCode] == 404) {
        ToastWidget.functionToastWidget(
            TextConstants.noDataFound, ColorConstants.toastErrorColor);
        setState(() {
          companies = [];
        });
      } else if (response.data[ModelConstants.apiStatusCode] == 400) {
        ToastWidget.functionToastWidget(
            TextConstants.badRequest, ColorConstants.toastErrorColor);
      } else {
        ToastWidget.functionToastWidget(
            TextConstants.allCompanyErrorToast, ColorConstants.toastErrorColor);
      }
      return response.data;
    } on DioError catch (e) {
      ToastWidget.functionToastWidget(
          e.toString(), ColorConstants.toastWarningColor);
    }
  }

  // ---------------------------------------------- Get All Companies Function End ----------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: companies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    var companyId = companies[index][ModelConstants.companyId];
                    var companyName =
                        companies[index][ModelConstants.companyName];
                    var companyLocation =
                        companies[index][ModelConstants.companyLocation];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleCompanyScreen(
                                comId: companyId,
                                comName: companyName,
                                comLocation: companyLocation)));
                  },
                  onLongPress: () {
                    var companyId = companies[index][ModelConstants.companyId];
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              TextConstants.alertTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConstants.alertTitleFontSize,
                                  color: ColorConstants.primaryColor),
                            ),
                            content: const Text(
                              TextConstants.alertDeleteContent,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: SizeConstants.alertContentFontSize,
                                  color: ColorConstants.primaryColor),
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  TextConstants.alertButtonCancel,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConstants.alertButtonFontSize,
                                      color: ColorConstants.primaryColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  TextConstants.alertButtonConfirm,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConstants.alertButtonFontSize,
                                      color: ColorConstants.primaryColor),
                                ),
                                onPressed: () {
                                  CompanyService()
                                      .deleteCompanyById(companyId, context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        SizeConstants.cardPaddingHorizontal,
                        SizeConstants.cardWithAppBarPaddingTop,
                        SizeConstants.cardPaddingHorizontal,
                        SizeConstants.cardPaddingBottom),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            SizeConstants.cardBorderRadius),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(
                                SizeConstants.cardPaddingAll),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  TextConstants.companiesImageLink,
                                  height: SizeConstants.cardImageHeight,
                                  width: SizeConstants.cardImageWidth,
                                  fit: BoxFit.contain,
                                ),
                                Container(
                                    width: SizeConstants.cardContainerWidth),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          height: SizeConstants
                                              .cardContainerMinHeight),
                                      Text(
                                        TextConstants.cardCompanyName,
                                        style: TextStyle(
                                          color: ColorConstants
                                              .cardAttributeTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConstants
                                              .cardAttributeTextFontSize,
                                        ),
                                      ),
                                      Container(
                                          height: SizeConstants
                                              .cardContainerMinHeight),
                                      Text(
                                        (companies[index]
                                                [ModelConstants.companyName]
                                            .toString()),
                                        maxLines: 3,
                                        style: TextStyle(
                                          color:
                                              ColorConstants.cardValueTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: SizeConstants
                                              .cardValueTextFontSize,
                                        ),
                                      ),
                                      Container(
                                          height: SizeConstants
                                              .cardContainerMaxHeight),
                                      Text(
                                        TextConstants.cardCompanyLocation,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: ColorConstants
                                              .cardAttributeTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConstants
                                              .cardAttributeTextFontSize,
                                        ),
                                      ),
                                      Container(
                                          height: SizeConstants
                                              .cardContainerMaxHeight),
                                      Text(
                                        (companies[index]
                                                [ModelConstants.companyLocation]
                                            .toString()),
                                        maxLines: 1,
                                        style: TextStyle(
                                          color:
                                              ColorConstants.cardValueTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: SizeConstants
                                              .cardValueTextFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
