import 'package:flutter/material.dart';

import 'package:frontend/src/features/core/screens/add_workout_plan/pland_workout_detail_screen.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';

class PlandWorkoutListScreen extends StatelessWidget {
  const PlandWorkoutListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("workoutList".tr),
      ),
      body: FutureBuilder<Box<Workout>>(
        future: Hive.openBox<Workout>('workouts'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final workoutsBox = snapshot.data;
            if (workoutsBox == null || workoutsBox.isEmpty) {
              return Center(child: Text("noWorkoutsFound".tr));
            }
            return ListView.builder(
              itemCount: workoutsBox.length,
              itemBuilder: (context, index) {
                final workout = workoutsBox.getAt(index);
                return ListTile(
                  title: Text(workout!.workoutName),
                  subtitle: Text("${workout.workoutStartTime}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlandWorkoutDetailScreen(workout: workout),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
