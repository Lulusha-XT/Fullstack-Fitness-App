import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/services/exercise_category_service.dart';

class StaticExerciseCategoryNotifier
    extends StateNotifier<List<ExerciseCategory>> {
  StaticExerciseCategoryNotifier(this._excerciseCategoryService)
      : super(<ExerciseCategory>[]);
  final ExerciseCategoryService _excerciseCategoryService;
  Future<void> loadExercisesFromJson() async {
    List<ExerciseCategory> exercises =
        await _excerciseCategoryService.loadExerciseCategoryFromAssets();
    state = exercises;
  }
}
