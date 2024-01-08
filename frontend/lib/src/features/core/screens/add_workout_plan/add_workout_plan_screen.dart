import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/database/hive_service.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';
import 'package:frontend/src/features/core/screens/add_workout_plan/widgets/add_workout_widgets.dart';
import 'package:frontend/src/features/core/screens/add_workout_plan/widgets/exercise_expandable_list_item.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';

class AddWorkoutPlanScreen extends ConsumerWidget {
  const AddWorkoutPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(staticExerciseProvider.notifier).loadExercisesFromJson();
    final exerciseCategories = ref.watch(staticExerciseProvider);

    if (exerciseCategories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "chooseExercise".tr,
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: exerciseCategories.length,
                itemBuilder: (context, index) {
                  final exerciseCategory = exerciseCategories[index];
                  return ExerciseExpandableListItem(
                    exerciseCategory: exerciseCategory,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreateWorkoutDialog(context);
        },
        label: Text("createWorkout".tr),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddWorkoutPlanDialog(
          onSubmit: (Workout workout) {
            _submitSelectedExercises(context, workout);
          },
        );
      },
    );
  }

  void _submitSelectedExercises(BuildContext context, Workout workout) async {
    final hiveService = HiveService();
    final selectedExerciseCategories = await hiveService.getExerciseCategory();
    final workoutSelectedExerciseCategories =
        selectedExerciseCategories.map((exerciseCategory) {
      return ExerciseCategory(
        exerciseCategoryId: exerciseCategory.exerciseCategoryId,
        exerciseCategoryName: exerciseCategory.exerciseCategoryName,
        exerciseCategoryThumbnailImageUrl:
            exerciseCategory.exerciseCategoryThumbnailImageUrl,
        exercise: exerciseCategory.exercise,
      );
    }).toList();

    workout.exerciseCategory = workoutSelectedExerciseCategories;

    hiveService.storeWorkout(workout);
    hiveService.clearExerciseCategory();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("workoutCreated".tr)),
    );
  }
}
