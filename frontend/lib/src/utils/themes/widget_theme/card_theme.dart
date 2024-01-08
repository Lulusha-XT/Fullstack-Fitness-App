import 'package:flutter/material.dart';

import 'package:frontend/src/constants/colors.dart';

class CardThem {
  CardThem._();

  static CardTheme ligthCardTheme = const CardTheme(
    shadowColor: AppColors.cDarkColor,
  );

  static CardTheme darkCardTheme = const CardTheme(
    shadowColor: AppColors.cGrey,
  );
}
