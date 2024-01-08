import 'package:flutter/material.dart';
import 'package:frontend/src/constants/styles.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/widgets/bmi_card.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/widgets/bmi_large_button.dart';
import 'package:frontend/src/features/core/services/user_service.dart';
import 'package:get/get.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.bmi});
  final double bmi;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "bmiTitle".tr,
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'yourResults'.tr,
                textAlign: TextAlign.center,
                style: cLargeTextStyle,
              ),
              const SizedBox(height: 17),
              Expanded(
                child: BMICard(
                  heights: 50.0,
                  widths: 40.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          UserService.getCategory(bmi).toUpperCase(),
                          style: cLargeTextStyle,
                        ),
                        Text(
                          bmi.toString(),
                          style: cLargeTextStyle,
                        ),
                        Text(
                          UserService.getInterpretation(bmi),
                          style: cLargeTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
              BMILargeButton(
                text: 'tryAgain'.tr,
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
