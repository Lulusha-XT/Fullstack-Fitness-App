import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';

class CTextFormFieldTheme {
  CTextFormFieldTheme._();
  static InputDecorationTheme ligthInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: AppColors.cSecondaryColor,
    floatingLabelStyle: TextStyle(color: AppColors.cSecondaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: AppColors.cSecondaryColor),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: AppColors.cPrimaryColor,
    floatingLabelStyle: TextStyle(color: AppColors.cPrimaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: AppColors.cPrimaryColor),
    ),
  );
}
