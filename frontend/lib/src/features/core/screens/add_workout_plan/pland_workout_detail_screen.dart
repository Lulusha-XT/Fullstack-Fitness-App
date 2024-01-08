import 'package:flutter/material.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';

class PlandWorkoutDetailScreen extends StatelessWidget {
  const PlandWorkoutDetailScreen({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.workoutName),
      ),
      body: ListView.builder(
        itemCount: workout.exerciseCategory!.length,
        itemBuilder: (context, index) {
          final exerciseCategory = workout.exerciseCategory![index];
          return ExpansionTile(
            title: Text(exerciseCategory.exerciseCategoryName),
            children: exerciseCategory.exercise!.map((exercise) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: ExactAssetImage(exercise.exerciseThumbnail),
                ),
                title: Text(exercise.exerciseName),
                subtitle: const Text('12 reps, 4 sets'),
                trailing: Icon(
                  exercise.isSelected! ? Icons.check : Icons.add,
                  color: exercise.isSelected! ? Colors.green : Colors.grey,
                ),
                onTap: () {
                  // Handle exercise tap if needed
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
