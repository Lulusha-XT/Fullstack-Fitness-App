import 'package:flutter/material.dart';

import 'package:frontend/src/constants/colors.dart';

class IconThem {
  IconThem._();

  static IconThemeData ligthIconTheme = const IconThemeData(
    color: AppColors.cSecondaryColor,
  );

  static IconThemeData darkIconTheme = const IconThemeData(
    color: AppColors.cPrimaryColor,
  );
}
