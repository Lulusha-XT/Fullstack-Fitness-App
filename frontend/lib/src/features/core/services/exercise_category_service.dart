import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:http/http.dart' as http;

final exerciseCategoryService = Provider((ref) => ExerciseCategoryService());

class ExerciseCategoryService {
  static var client = http.Client();
  Future<List<ExerciseCategory>?> getExerciseCategory() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.workoutAPI);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return exerciseCategoryFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<ExerciseCategory?> addExerciseCategory(
      ExerciseCategory exerciseCategory) async {
    return exerciseCategory;
  }

  Future<List<ExerciseCategory>> loadExerciseCategoryFromAssets() async {
    String data = await rootBundle.loadString('json/excercise.json');
    List<dynamic> excerciseJsonList = json.decode(data);
    return excerciseJsonList
        .map(
          (json) => ExerciseCategory(
            exerciseCategoryId: json["excercise_category_id"],
            exerciseCategoryName: json['excercise_category_name'],
            exerciseCategoryThumbnailImageUrl:
                json['excercise_category_thumbnail_path'],
            exercise: exerciseFromJson(json['excercise']),
          ),
        )
        .toList();
  }
}
