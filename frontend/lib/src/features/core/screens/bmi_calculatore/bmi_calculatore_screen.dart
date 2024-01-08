import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/constants/styles.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/result_page.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/widgets/bmi_card.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/widgets/bmi_content_control.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/widgets/bmi_large_button.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/features/core/services/user_service.dart';
import 'package:get/get.dart';

class BmiCalculatoreScreen extends StatefulWidget {
  const BmiCalculatoreScreen({super.key});

  @override
  State<BmiCalculatoreScreen> createState() => _BmiCalculatoreScreenState();
}

class _BmiCalculatoreScreenState extends State<BmiCalculatoreScreen> {
  final _formKey = GlobalKey<FormState>();
  String? excercise;
  String? selectedGender;
  String? aim;
  int height = 180;
  int weight = 60;
  int age = 30;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.0.w, right: 4.0.w),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 60.0.h,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'aim'.tr,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'pleaseSelectYourAim'.tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              aim = value;
                            });
                          }
                        },
                        onSaved: (value) {
                          if (value != null) {
                            aim = value;
                          }
                        },
                        items:
                            ['Loose', 'Maintain', 'Gain'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 60.0.h,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "exercise".tr,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'pleaseSelectYourExerciseLevel'.tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              excercise = value;
                            });
                          }
                        },
                        onSaved: (value) {
                          if (value != null) {
                            excercise = value;
                          }
                        },
                        items: [
                          'Little To No Exercise',
                          'Moderately Active',
                          'Very Active',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 60.0.h,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'gender'.tr,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'pleaseSelectYourGender'.tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedGender = value;
                            });
                          }
                        },
                        onSaved: (value) {
                          if (value != null) {
                            selectedGender = value;
                          }
                        },
                        items: ['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BMICard(
                heights: 60.0.h,
                widths: MediaQuery.of(context).size.width,
                child: BMIContentControl(
                  label: 'wigth'.tr,
                  value: weight,
                  unit: 'kg',
                  onDecrease: () => setState(() => weight--),
                  onIncrease: () => setState(() => weight++),
                ),
              ),
              const SizedBox(height: 20),
              BMICard(
                heights: 60.0.h,
                widths: MediaQuery.of(context).size.width,
                child: BMIContentControl(
                  label: 'age'.tr,
                  value: age,
                  onDecrease: () => setState(() => age--),
                  onIncrease: () => setState(() => age++),
                ),
              ),
              const SizedBox(height: 20),
              BMICard(
                heights: 120.h,
                widths: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'heigth'.tr,
                      style: cLargeTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: cValueStyle,
                        ),
                        const Text(
                          'cm',
                          style: cLargeTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 15,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 30,
                        ),
                      ),
                      child: Slider(
                          min: cMinHeight,
                          max: cMaxHeight,
                          value: height.toDouble(),
                          onChanged: (newHeight) {
                            setState(() {
                              height = newHeight.round();
                            });
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BMILargeButton(
                text: "calculateBMI".tr,
                onTap: () {
                  if (excercise == null) {
                    print("Pleaase select excercie");
                  } else if (selectedGender == null) {
                    print("Pleaase select your gender");
                  } else if (aim == null) {
                    print("Pleaase select your gender");
                  } else {
                    final tdee = UserService.calculateTDEE(
                        weight, height, age, selectedGender!, excercise!);
                    final bmr = UserService.calculateBMR(
                        selectedGender!, weight, height, age);
                    print("Tdee value ${tdee}");
                    print("Bmr value ${bmr}");
                    var dietPlanValue =
                        UserService.calculateMacronutrients(tdee, aim!);
                    print(" Value${dietPlanValue}");
                    double bmi = UserService.calculateBMI(height, weight);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ResultPage(
                            bmi: bmi,
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
