import 'package:flutter/material.dart';

class BMIRoundIconButton extends StatelessWidget {
  const BMIRoundIconButton(
      {super.key, required this.onPressed, required this.icon});

  final IconData icon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: const CircleBorder(),
      constraints: const BoxConstraints.tightFor(
        width: 35.0,
        height: 35.0,
      ),
      elevation: 6,
      onPressed: onPressed,
      child: Icon(
        icon,
        size: 20,
      ),
    );
  }
}
