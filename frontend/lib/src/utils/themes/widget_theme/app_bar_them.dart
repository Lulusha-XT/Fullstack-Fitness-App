import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/colors.dart';

class AppBarThem {
  AppBarThem._();

  static AppBarTheme ligthAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.cWhiteClr,
    foregroundColor: AppColors.cSecondaryColor,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 17.sp,
      color: AppColors.cSecondaryColor,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: const IconThemeData(color: AppColors.cSecondaryColor),
    iconTheme: const IconThemeData(color: AppColors.cSecondaryColor),
  );

  static AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.cSecondaryColor,
    foregroundColor: AppColors.cPrimaryColor,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 17.sp,
      color: AppColors.cPrimaryColor,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: const IconThemeData(color: AppColors.cPrimaryColor),
    iconTheme: const IconThemeData(color: AppColors.cPrimaryColor),
  );
}
