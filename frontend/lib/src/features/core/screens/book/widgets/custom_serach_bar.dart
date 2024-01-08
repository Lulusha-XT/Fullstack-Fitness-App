import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:get/get.dart';

class CustomeSearchBar extends StatelessWidget {
  const CustomeSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: AppColors.cDarkGrey,
            filled: true,
            contentPadding: const EdgeInsets.all(10),
            hintText: "search".tr,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.search),
            ),
            suffixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.filter_list_rounded),
            ),
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
