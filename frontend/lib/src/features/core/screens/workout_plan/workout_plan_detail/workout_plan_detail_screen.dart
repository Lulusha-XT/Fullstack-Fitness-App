import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';
import 'package:frontend/src/features/core/screens/workout_plan/widgets/workout_exercise_expandable_list_item_widget.dart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkoutPlanDetailScreen extends StatelessWidget {
  const WorkoutPlanDetailScreen({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: _getBGCLr(workout.workoutColor!),
      appBar: AppBar(
        backgroundColor: _getBGCLr(workout.workoutColor!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  workout.workoutName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white30,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "60 mins",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shutter_speed,
                          color: Colors.white30,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "easy".tr,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: workout.exerciseCategory!.length,
                  itemBuilder: (_, index) {
                    ExerciseCategory exerciseCategory =
                        workout.exerciseCategory![index];
                    return WorkoutExerciseExpandableListItem(
                      exerciseCategory: exerciseCategory,
                      workoutColor: workout.workoutColor!,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getBGCLr(int no) {
    switch (no) {
      case 0:
        return AppColors.cOrange;
      case 1:
        return AppColors.cPinkClr;
      case 2:
        return AppColors.cYellowClr;
      default:
        return AppColors.cOrange;
    }
  }
}
