import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';

class TextFieldSearchWidget {
  static functionTextFieldSearch(var labelValue, var controllerValue,
      var futureFunctionValue, getSelectedValues) {
    return TextFieldSearch(
        label: labelValue,
        controller: controllerValue,
        scrollbarDecoration: ScrollbarDecoration(
            controller: ScrollController(),
            theme: ScrollbarThemeData(
                radius:
                    const Radius.circular(SizeConstants.textFieldBorderRadius),
                thickness: MaterialStateProperty.all(
                    SizeConstants.searchTextFieldThickness),
                trackColor:
                    MaterialStateProperty.all(ColorConstants.textFieldColor))),
        future: futureFunctionValue,
        getSelectedValue: getSelectedValues
        // initialList: futureFunctionValue,
        );
  }
}
