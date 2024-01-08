import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/sizes.dart';

class COutlinedButtonTheme {
  COutlinedButtonTheme._(); //to a void creating instance
  /* Ligth Theme*/
  static final ligthOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: AppColors.cSecondaryColor,
      side: const BorderSide(color: AppColors.cSecondaryColor),
      padding: const EdgeInsets.symmetric(vertical: cButtonHeigth),
    ),
  );
  /* Ligth Theme*/
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: AppColors.cWhiteColor,
      side: const BorderSide(color: AppColors.cWhiteColor),
      padding: const EdgeInsets.symmetric(vertical: cButtonHeigth),
    ),
  );
}
