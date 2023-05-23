import 'package:attendance_marker_frontend/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class DropdwonListWidget {
  static functionDropdownList(var iconValue, var selectValue, var validatorValue, var onChangeValue,
       var itemsValue) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        prefixIcon: iconValue,
        prefixIconColor: ColorConstants.textFieldIcon,
        hintTextDirection: null,
        fillColor: ColorConstants.fillColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(SizeConstants.textFieldBorderRadius),
          borderSide: const BorderSide(color: ColorConstants.focusBorder),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(SizeConstants.textFieldBorderRadius),
          borderSide: const BorderSide(
            color: ColorConstants.errorBorder,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(SizeConstants.textFieldBorderRadius),
          borderSide: const BorderSide(
            color: ColorConstants.errorBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(SizeConstants.textFieldBorderRadius),
          borderSide: const BorderSide(
            color: ColorConstants.enabledColor,
            width: SizeConstants.textFieldEnabledBorderWidth,
          ),
        ),
      ),
      isExpanded: true,
      dropdownColor: ColorConstants.fillColor,
      hint: Text(selectValue,
          textDirection: null,
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: SizeConstants.textFieldFontSize,
              color: ColorConstants.textFieldColor)),
      validator: validatorValue,
      onChanged: onChangeValue,
      items: itemsValue
    );
  }
}
