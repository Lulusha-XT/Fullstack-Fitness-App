import 'package:flutter/material.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/constants/styles.dart';

class BMIconContent extends StatelessWidget {
  const BMIconContent({
    super.key,
    required this.icon,
    required this.label,
    this.labelColor = Colors.grey,
  });
  final IconData icon;
  final String label;

  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: cIconSize,
        ),
        const SizedBox(
          height: cGabSize,
        ),
        Text(
          label,
          style: cLargeTextStyle,
        ),
      ],
    );
  }
}
