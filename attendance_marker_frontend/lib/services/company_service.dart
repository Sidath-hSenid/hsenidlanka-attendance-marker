import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/variables/backend_api.dart';
import '../utils/variables/color_palette.dart';
import '../utils/variables/size_values.dart';
import '../utils/variables/text_values.dart';

class CompanyService{
  Dio dio = Dio();

  
  addCompany(companyName, companyLocation) async {
    try {
      await dio.post(BackendAPI.addCompanyAPI,
          data: {
            'companyName': companyName,
            'companyLocation': companyLocation,
          },
          options: Options(contentType: Headers.jsonContentType));

      // return Get.off(() => MainMenu());
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: TextValues.companyServiceAddCompanyErrorToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorPalette.toastErrorColor,
          textColor: ColorPalette.toastTextColor,
          fontSize: SizeValues.toastFontSize);
    }
  }
}