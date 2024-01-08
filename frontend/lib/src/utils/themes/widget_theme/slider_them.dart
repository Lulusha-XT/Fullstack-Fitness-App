import 'package:flutter/material.dart';

import 'package:frontend/src/constants/colors.dart';

class SliderThem {
  SliderThem._();

  static SliderThemeData ligthSliderTheme = const SliderThemeData(
    activeTrackColor: AppColors.cGrey,
    activeTickMarkColor: AppColors.cSecondaryColor,
    inactiveTrackColor: AppColors.cDarkColor,
  );

  static SliderThemeData darkSliderTheme = const SliderThemeData(
    activeTrackColor: AppColors.cPrimaryColor,
    activeTickMarkColor: AppColors.cPrimaryColor,
    inactiveTrackColor: AppColors.cDarkColor,
  );
}
