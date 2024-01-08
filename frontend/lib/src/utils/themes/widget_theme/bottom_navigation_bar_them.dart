import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';

class BottomNavigationBarThem {
  BottomNavigationBarThem._();

  static BottomNavigationBarThemeData ligthBottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
    backgroundColor: AppColors.cPrimaryColor,
    selectedItemColor: AppColors.cOrange,
    selectedIconTheme: IconThemeData(
      color: AppColors.cOrange,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.black12,
    ),
  );

  static BottomNavigationBarThemeData darkBottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    backgroundColor: AppColors.cDarkColor,
    selectedItemColor: AppColors.cOrange,
    selectedIconTheme: IconThemeData(
      color: AppColors.cOrange,
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColors.cGrey,
    ),
  );
}
