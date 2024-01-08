import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';

class BMICard extends StatelessWidget {
  const BMICard({
    super.key,
    this.child,
    this.onSelect,
    required this.heights,
    required this.widths,
  });

  final Widget? child;
  final Function()? onSelect;
  final double heights;
  final double widths;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Card(
        shadowColor: Colors.white,
        shape: BeveledRectangleBorder(
          side: BorderSide(
            color: AppColors.cGrey.withOpacity(0.5),
          ),
        ),
        child: SizedBox(
          height: heights,
          width: widths,
          child: child,
        ),
      ),
    );
  }
}
