import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';

class FormTextFieldWidget {
  static functionTextFormField(
      var enableValue,
      var controllerValue,
      onChangedValue,
      var lableValue,
      var obscureValue,
      var iconValue,
      validatorValue) {
    return TextFormField(
      enabled: enableValue,
      controller: controllerValue,
      onChanged: onChangedValue,
      validator: validatorValue,
      obscureText: obscureValue,
      style: const TextStyle(color: ColorConstants.textColor),
      decoration: InputDecoration(
        prefixIcon: iconValue,
        prefixIconColor: ColorConstants.textFieldIcon,
        labelText: lableValue,
        labelStyle: const TextStyle(
            fontSize: SizeConstants.textFieldFontSize,
            color: ColorConstants.textFieldColor),
        fillColor: ColorConstants.fillColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(SizeConstants.textFieldBorderRadius),
          borderSide: const BorderSide(
            color: ColorConstants.focusBorder,
          ),
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
    );
  }
}
