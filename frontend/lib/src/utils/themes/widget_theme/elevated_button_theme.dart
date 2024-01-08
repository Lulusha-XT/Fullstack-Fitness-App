import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/sizes.dart';

class CElevatedButtonTheme {
  CElevatedButtonTheme._(); //to a void creating instance
  /* Ligth Theme*/
  static final ligthElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: AppColors.cWhiteColor,
      backgroundColor: AppColors.cOrange,
      side: const BorderSide(color: AppColors.cOrange),
      padding: const EdgeInsets.symmetric(vertical: cButtonHeigth),
    ),
  );
  /* Ligth Theme*/
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: AppColors.cSecondaryColor,
      backgroundColor: AppColors.cOrange,
      side: const BorderSide(color: AppColors.cOrange),
      padding: const EdgeInsets.symmetric(vertical: cButtonHeigth),
    ),
  );
}
