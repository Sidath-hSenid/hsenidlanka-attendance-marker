import 'package:attendance_marker_frontend/utils/variables/icon_palette.dart';
import 'package:attendance_marker_frontend/utils/variables/size_values.dart';
import 'package:attendance_marker_frontend/utils/widgets/navigational_drawer_widget.dart';
import 'package:flutter/material.dart';

import '../variables/color_palette.dart';

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
            IconPalette.appLogOut,
            color: ColorPalette.appBarIconColor,
            size: SizeValues.appBarIconSize,
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
          color: ColorPalette.appBarTitleText,
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
          color: ColorPalette.appBarTitleText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
