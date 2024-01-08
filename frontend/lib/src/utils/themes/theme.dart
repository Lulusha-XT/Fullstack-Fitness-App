import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/utils/themes/widget_theme/app_bar_them.dart';
import 'package:frontend/src/utils/themes/widget_theme/bottom_navigation_bar_them.dart';
import 'package:frontend/src/utils/themes/widget_theme/card_theme.dart';
import 'package:frontend/src/utils/themes/widget_theme/elevated_button_theme.dart';
import 'package:frontend/src/utils/themes/widget_theme/expansion_tile_theme.dart';
import 'package:frontend/src/utils/themes/widget_theme/floating_action_button_theme.dart';
import 'package:frontend/src/utils/themes/widget_theme/icon_them.dart';
import 'package:frontend/src/utils/themes/widget_theme/outlined_button_theme.dart';
import 'package:frontend/src/utils/themes/widget_theme/slider_them.dart';
import 'package:frontend/src/utils/themes/widget_theme/text_field_theme.dart';
import 'widget_theme/txt_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CAppTheme {
  CAppTheme._();
  static ThemeData ligthTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: CTextTheme.ligthTextTheme,
    outlinedButtonTheme: COutlinedButtonTheme.ligthOutlinedButtonTheme,
    elevatedButtonTheme: CElevatedButtonTheme.ligthElevatedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.ligthInputDecorationTheme,
    bottomNavigationBarTheme:
        BottomNavigationBarThem.ligthBottomNavigationBarTheme,
    appBarTheme: AppBarThem.ligthAppBarTheme,
    iconTheme: IconThem.ligthIconTheme,
    sliderTheme: SliderThem.ligthSliderTheme,
    floatingActionButtonTheme:
        FloatingActionButtonThem.ligthFloatingActionButtonThemeData,
    expansionTileTheme: ExpansionTileThem.ligthExpansionTileThem,
    cardTheme: CardThem.ligthCardTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: CTextTheme.darkTextTheme,
    outlinedButtonTheme: COutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.darkInputDecorationTheme,
    bottomNavigationBarTheme:
        BottomNavigationBarThem.darkBottomNavigationBarTheme,
    appBarTheme: AppBarThem.darkAppBarTheme,
    iconTheme: IconThem.darkIconTheme,
    sliderTheme: SliderThem.darkSliderTheme,
    floatingActionButtonTheme:
        FloatingActionButtonThem.darkFloatingActionButtonThemeData,
    expansionTileTheme: ExpansionTileThem.darkExpansionTileThem,
    cardTheme: CardThem.darkCardTheme,
  );
}

TextStyle get subHeadingStyle {
  return TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? AppColors.cWhiteClr : AppColors.cGrey,
  );
}

TextStyle get headingStyle {
  return TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get titleStyle {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}

TextStyle get subTitleStyle {
  return const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
