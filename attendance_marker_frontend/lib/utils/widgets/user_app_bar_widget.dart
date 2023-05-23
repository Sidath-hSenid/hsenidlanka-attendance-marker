import 'package:attendance_marker_frontend/services/company_service.dart';
import 'package:attendance_marker_frontend/utils/constants/icon_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';

import '../../services/attendance_service.dart';
import '../../services/user_service.dart';
import '../constants/color_constants.dart';

class UserAppBarWidget {
  static functionAppBarInside(var appBarTextValue, var context) {
    return AppBar(
      // leading: IconButton(
      //     alignment: Alignment.centerLeft,
      //     icon: const Icon(
      //       IconPalette.appBarMenu,
      //       color: ColorPalette.appBarIconColor,
      //       size: SizeValues.appBarIconSize,
      //     ),
      //     onPressed: () {

      //     }),
      actions: <Widget>[
        IconButton(
          alignment: Alignment.centerRight,
          icon: const Icon(
            IconConstants.appLogOut,
            color: ColorConstants.appBarIconColor,
            size: SizeConstants.appBarIconSize,
          ),
          onPressed: () {
            // do something
          },
        ),
      ],
      elevation: 0,
      centerTitle: true,
      title: Text(
        appBarTextValue,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ColorConstants.appBarTitleText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static functionAppBarBackButton(var appBarTextValue, context) {
    return AppBar(
      leading: BackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
    );
  }

  static functionAppBarInsideBackButton(var appBarTextValue, context) {
    return AppBar(
      leading: BackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        appBarTextValue,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ColorConstants.appBarTitleText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static functionAppBarInsideBackButtonWithDeleteCompany(
      var appBarTextValue, var companyIdValue, context) {
    return AppBar(
      leading: BackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        appBarTextValue,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ColorConstants.appBarTitleText,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          alignment: Alignment.centerRight,
          icon: const Icon(
            IconConstants.appDelete,
            color: ColorConstants.appBarIconColor,
            size: SizeConstants.appBarIconSize,
          ),
          onPressed: () {
            CompanyService().deleteCompanyById(companyIdValue, context);
          },
        ),
      ],
    );
  }

  static functionAppBarInsideBackButtonWithDeleteUser(
      var appBarTextValue, var userIdValue, context) {
    return AppBar(
      leading: BackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        appBarTextValue,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ColorConstants.appBarTitleText,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          alignment: Alignment.centerRight,
          icon: const Icon(
            IconConstants.appDelete,
            color: ColorConstants.appBarIconColor,
            size: SizeConstants.appBarIconSize,
          ),
          onPressed: () {
            UserService().deleteUserById(userIdValue, context);
          },
        ),
      ],
    );
  }

  static functionAppBarInsideBackButtonWithDeleteAttendance(
      var appBarTextValue, var attendanceIdValue, context) {
    return AppBar(
      leading: BackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        appBarTextValue,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ColorConstants.appBarTitleText,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          alignment: Alignment.centerRight,
          icon: const Icon(
            IconConstants.appDelete,
            color: ColorConstants.appBarIconColor,
            size: SizeConstants.appBarIconSize,
          ),
          onPressed: () {
            AttendanceService().deleteAttendanceById(attendanceIdValue, context);
          },
        ),
      ],
    );
  }

}
