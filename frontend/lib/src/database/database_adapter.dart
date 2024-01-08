import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';

abstract class DatabaseAdapter {
  Future<void> storeExercise(Exercise exercise);

  Future<void> clearExercise();

  Future<void> removeExercise(int exerciseId);

  Future<void> storeExerciseCategory(ExerciseCategory exerciseCategory);

  Future<List<ExerciseCategory>> getExerciseCategory();

  Future<void> clearExerciseCategory();

  Future<void> removeExerciseCategory(int exerciseCategoryId);

  Future<void> storeWorkout(Workout workout);

  Future<List<Workout>> getWorkouts();

  Future<void> clearWorkout();

  Future<void> removeWorkout(int workoutId);
}
