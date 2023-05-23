import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/icon_constants.dart';
import '../constants/size_constants.dart';

class AdminAppBarWidget{
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
}