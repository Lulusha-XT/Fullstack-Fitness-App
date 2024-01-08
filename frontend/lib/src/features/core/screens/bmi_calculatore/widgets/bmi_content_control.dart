import 'package:flutter/material.dart';
import 'package:frontend/src/constants/styles.dart';
import 'bmi_round_icon_button.dart';

class BMIContentControl extends StatelessWidget {
  const BMIContentControl({
    super.key,
    required this.label,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
    this.unit = '',
  });
  final String label;
  final String unit;
  final int value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                label,
                style: cLargeTextStyle,
              ),
              const SizedBox(width: 15),
              Text(
                value.toString(),
                style: cValueStyle,
              ),
              Text(
                unit,
                style: cLargeTextStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BMIRoundIconButton(onPressed: onDecrease, icon: Icons.remove),
              const SizedBox(width: 10),
              BMIRoundIconButton(onPressed: onIncrease, icon: Icons.add),
            ],
          ),
        ],
      ),
    );
  }
}
