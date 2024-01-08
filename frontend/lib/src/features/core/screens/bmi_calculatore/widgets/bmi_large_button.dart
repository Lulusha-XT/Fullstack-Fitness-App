import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';

class BMILargeButton extends StatelessWidget {
  const BMILargeButton({super.key, required this.text, required this.onTap});
  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.cOrange,
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.cWhiteClr,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
