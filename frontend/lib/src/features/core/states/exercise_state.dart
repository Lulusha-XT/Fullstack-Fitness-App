import 'package:frontend/src/features/core/models/exercise_category_model.dart';

class ExerciseCategoryState {
  List<ExerciseCategory> exerciseCategory;
  bool hasNext;
  bool isLoading;

  ExerciseCategoryState({
    List<ExerciseCategory>? exerciseCategory,
    bool? hasNext = true,
    bool? isLoading = false,
  })  : exerciseCategory = exerciseCategory ?? [],
        hasNext = hasNext ?? true,
        isLoading = isLoading ?? false;

  ExerciseCategoryState copyWith({
    List<ExerciseCategory>? exerciseCategory,
    bool? hasNext,
    bool? isLoading,
  }) {
    return ExerciseCategoryState(
      exerciseCategory: exerciseCategory ?? this.exerciseCategory,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseCategoryState &&
          runtimeType == other.runtimeType &&
          exerciseCategory == other.exerciseCategory &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode =>
      exerciseCategory.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;
}
