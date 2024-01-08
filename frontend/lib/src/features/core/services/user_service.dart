import 'dart:math';
import 'package:frontend/src/features/core/models/macronutrient_model.dart';

class UserService {
  static double calculateBMI(int height, int weight) {
    double bmi = weight / pow(height / 100, 2);
    return bmi;
  }

  static double calculateBMR(String gender, int weight, int height, int age) {
    double bMR = 0;
    if (gender == "male") {
      bMR = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      bMR = 10 * weight + 6.25 * height - 5 * age - 161;
    }
    return bMR;
  }

  static double calculateTDEE(
      int weight, int height, int age, String gender, String exercise) {
    double bMR = calculateBMR(gender, weight, height, age);
    double tDEE = 0;
    if (exercise == "Little To No Exercise") {
      tDEE = bMR * 1.375;
    } else if (exercise == "Moderately Active") {
      tDEE = bMR * 1.55;
    } else if (exercise == "Very Active") {
      tDEE = bMR * 1.725;
    }
    return tDEE;
  }

  static String getCategory(double bmi) {
    String category = '';
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 25.0) {
      category = 'Normal';
    } else {
      category = 'Overweight';
    }
    return category;
  }

  static String getInterpretation(double bmi) {
    String interpretation = '';
    if (bmi < 18.5) {
      interpretation =
          'You have a lower than normal body weight. You can eat a bit more.';
    } else if (bmi < 25.0) {
      interpretation = 'You have a normal body weight. Good job!';
    } else {
      interpretation =
          'You have a higher than normal body weight. Try to exercise more.';
    }
    return interpretation;
  }

  static Macronutrient calculateMacronutrients(double tDEE, String aim) {
    Macronutrient macronutrient;
    double calorie = 0;
    double carbohydrates = 0;
    double protein = 0;
    double fat = 0;

    if (aim == "Loose") {
      calorie = tDEE * 0.8;
      protein = (calorie * 0.25) / 4;
      fat = (calorie * 0.3) / 9;
      carbohydrates = (calorie - (protein * 4 + fat * 9)) / 4;
    } else if (aim == "Maintain") {
      calorie = tDEE;
      protein = (calorie * 0.25) / 4;
      fat = (calorie * 0.25) / 9;
      carbohydrates = (calorie - (protein * 4 + fat * 9)) / 4;
    } else if (aim == "Gain") {
      calorie = tDEE + tDEE * 0.2;
      protein = (calorie * 0.3) / 4;
      fat = (calorie * 0.25) / 9;
      carbohydrates = (calorie - (protein * 4 + fat * 9)) / 4;
    }

    macronutrient = Macronutrient(
      macronutrientCalorie: calorie,
      macronutrientCarbohydrates: carbohydrates,
      macronutrientProtein: protein,
      macronutrientFat: fat,
    );
    return macronutrient;
  }
}
