import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/utils/assets.dart';
import 'package:frontend/src/utils/shared_service.dart';
import 'package:get/get.dart';

AppBar appBar(String title, BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(
        AssetsSvgs.drawerMenuSvg,
        color: AppColors.cOrange,
      ),
    ),
    title: Text(
      title,
    ),
    actions: [
      PopupMenuButton<int>(
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem<int>(
              value: 1,
              child: Text('setting'.tr),
            ),
            PopupMenuItem<int>(
              value: 2,
              child: Text('logout'.tr),
            ),
          ];
        },
        onSelected: (int value) async {
          // Handle the selected option here
          if (value == 1) {
            Navigator.of(context).pushNamed('/language_selection');
          } else if (value == 2) {
            await SharedService.logout(context);
          }
        },
        child: SvgPicture.asset(
          AssetsSvgs.settingSvg,
          height: 20,
          width: 20,
          color: AppColors.cOrange,
        ),
      ),
      const SizedBox(width: 15),
    ],
  );
}
