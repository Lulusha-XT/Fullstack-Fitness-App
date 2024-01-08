import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/services/exercise_category_service.dart';
import 'package:frontend/src/features/core/states/exercise_state.dart';

class ExerciseCategoryNotifier extends StateNotifier<ExerciseCategoryState> {
  ExerciseCategoryNotifier(this._exerciseCategoryService)
      : super(ExerciseCategoryState());
  final ExerciseCategoryService _exerciseCategoryService;
  Future<void> getExerciseCategory() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(isLoading: true);
    });
    final workout = await _exerciseCategoryService.getExerciseCategory();
    final newWorkout = [...state.exerciseCategory, ...workout!];
    if (workout.length % 10 != 0 || workout.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(exerciseCategory: newWorkout);
      //  _page++;
      state = state.copyWith(isLoading: false);
    });
  }

  Future<void> loadExercisesFromAssets() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    state = state.copyWith(isLoading: true);
    final exerciseCategory =
        await _exerciseCategoryService.loadExerciseCategoryFromAssets();

    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(exerciseCategory: exerciseCategory);
      state = state.copyWith(isLoading: false);
    });
  }
}
