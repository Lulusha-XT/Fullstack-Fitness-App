import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    this.text,
    this.fontSize,
    this.isUnderLine = false,
    this.color = Colors.white,
  });
  final String? text;
  final int? fontSize;
  final bool? isUnderLine;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 3, // space between underline and text
      ),
      child: Text(
        text!,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize!.toDouble(),
          fontFamily: "Avenir",
          fontWeight: FontWeight.w900,
          color: Get.isDarkMode ? color : Colors.black54,
        ),
      ),
    );
  }
}
