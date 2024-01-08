import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:frontend/src/features/core/models/food_model.dart';

class FoodsService {
  List<FoodModel> foods = [];
  final List<String> selectedFood;
  final double carbohydrates;
  final double protein;
  final double fat;

  FoodsService({
    required this.selectedFood,
    required this.foods,
    required this.carbohydrates,
    required this.protein,
    required this.fat,
  });
  Future<List<FoodModel>> loadFoods() async {
    final String response =
        await rootBundle.loadString('assets/data/food_data.json');
    final data = json.decode(response);
    for (var food in data) {
      foods.add(food.fromJson(food));
    }
    return foods;
  }

  List<double> getFoodSizes() {
    final len = selectedFood.length;
    final ch = carbohydrates / len;
    final pr = protein / len;
    final fa = fat / len;
    final arr = <double>[];
    for (final foodList in selectedFood) {
      for (var a = 0; a < 2; a++) {
        for (final food in foods) {
          if (food.name == foodList) {
            final gram1 = (ch / food.carbohydrates) * 10;
            final gram2 = (pr / food.protein) * 10;
            final gram3 = (fa / food.fat) * 10;
            if (a == 0) {
              arr.add(((gram1 + gram2 + gram3) / 1000) * 0.1);
            } else {
              arr.add((gram1 + gram2 + gram3) / 1000);
            }
          }
        }
      }
    }
    return arr;
  }
}
