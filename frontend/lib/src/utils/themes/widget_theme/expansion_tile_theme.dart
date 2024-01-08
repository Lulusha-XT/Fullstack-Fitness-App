import 'package:flutter/material.dart';

import 'package:frontend/src/constants/colors.dart';

class ExpansionTileThem {
  ExpansionTileThem._();

  static ExpansionTileThemeData ligthExpansionTileThem =
      const ExpansionTileThemeData(
    backgroundColor: AppColors.cWhiteClr,
    textColor: AppColors.cOrange,
    iconColor: AppColors.cOrange,
    collapsedIconColor: AppColors.cOrange,
  );

  static ExpansionTileThemeData darkExpansionTileThem =
      const ExpansionTileThemeData(
    backgroundColor: AppColors.cDarkGrey,
    collapsedIconColor: AppColors.cOrange,
    iconColor: AppColors.cOrange,
    textColor: AppColors.cOrange,
  );
}
