import 'package:hive/hive.dart';
import 'package:frontend/src/database/database_adapter.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';

class HiveService extends DatabaseAdapter {
  // Exercise methods
  @override
  Future<void> storeExercise(Exercise exercise) async {
    final selectedExercisesBox =
        await Hive.openBox<Exercise>('selected_exercises');
    selectedExercisesBox.put(exercise.exerciseId, exercise);
  }

  @override
  Future<void> clearExercise() async {
    final selectedExercisesBox =
        await Hive.openBox<Exercise>('selected_exercises');
    selectedExercisesBox.clear();
  }

  @override
  Future<void> removeExercise(int exerciseId) async {
    final selectedExercisesBox =
        await Hive.openBox<Exercise>('selected_exercises');
    selectedExercisesBox.delete(exerciseId);
  }

  // ExerciseCategory methods
  @override
  Future<void> storeExerciseCategory(ExerciseCategory exerciseCategory) async {
    final exerciseCategoriesBox =
        await Hive.openBox<ExerciseCategory>('exercise_categories');
    exerciseCategoriesBox.put(
        exerciseCategory.exerciseCategoryId, exerciseCategory);
  }

  @override
  Future<List<ExerciseCategory>> getExerciseCategory() async {
    final selectedExerciseCategoriesBox =
        await Hive.openBox<ExerciseCategory>('exercise_categories');
    final selectedExerciseCategories =
        selectedExerciseCategoriesBox.values.toList();
    return selectedExerciseCategories;
  }

  @override
  Future<void> clearExerciseCategory() async {
    final selectedExerciseCategoriesBox =
        await Hive.openBox<ExerciseCategory>('exercise_categories');
    selectedExerciseCategoriesBox.clear();
  }

  @override
  Future<void> removeExerciseCategory(int exerciseCategoryId) async {
    final selectedExerciseCategoriesBox =
        await Hive.openBox<ExerciseCategory>('exercise_categories');
    selectedExerciseCategoriesBox.delete(exerciseCategoryId);
  }

  // Workout methods
  @override
  Future<void> storeWorkout(Workout workout) async {
    final workoutsBox = await Hive.openBox<Workout>('workouts');
    workoutsBox.add(workout);
  }

  @override
  Future<List<Workout>> getWorkouts() async {
    final workoutsBox = await Hive.openBox<Workout>('workouts');
    final workouts = workoutsBox.values.toList();
    return workouts;
  }

  @override
  Future<void> clearWorkout() async {
    final workoutsBox = await Hive.openBox<Workout>('workouts');
    workoutsBox.clear();
  }

  @override
  Future<void> removeWorkout(int workoutId) async {
    final workoutsBox = await Hive.openBox<Workout>('workouts');
    workoutsBox.clear();
  }
}
