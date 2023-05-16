import 'package:attendance_marker_frontend/utils/variables/color_palette.dart';
import 'package:attendance_marker_frontend/utils/variables/size_values.dart';
import 'package:flutter/material.dart';

class FormTextFieldWidget{
  static functionTextFormField(var textValue, var lableValue, var obscureValue, var iconValue, validatorValue){
    return TextFormField(
      controller: TextEditingController(text: textValue),
      onChanged: (value) {
        textValue = value;
      },
      validator: validatorValue,
      obscureText: obscureValue,
      style: const TextStyle(color: ColorPalette.textColor),
      decoration: InputDecoration(
        prefixIcon: iconValue, prefixIconColor: ColorPalette.textFieldIcon,
        labelText: lableValue,
        labelStyle:
            const TextStyle(fontSize: SizeValues.textFieldFontSize, color: ColorPalette.textFieldColor),
        fillColor: ColorPalette.fillColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeValues.textFieldBorderRadius),
          borderSide: const BorderSide(
            color: ColorPalette.focusBorder,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeValues.textFieldBorderRadius),
          borderSide: const BorderSide(
            color: ColorPalette.errorBorder,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeValues.textFieldBorderRadius),
          borderSide: const BorderSide(
            color: ColorPalette.errorBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeValues.textFieldBorderRadius),
          borderSide: const BorderSide(
            color: ColorPalette.enabledColor,
            width: SizeValues.textFieldEnabledBorderWidth,
          ),
        ),
      ),
    );
  }
}
