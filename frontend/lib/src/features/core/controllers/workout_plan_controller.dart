import 'package:frontend/src/features/core/models/workout_model.dart';
import 'package:frontend/src/database/hive_service.dart';
import 'package:get/get.dart';

class WorkoutPlanController extends GetxController {
  final hiveService = HiveService();
  var workoutPlanList = <Workout>[].obs;

  Future<void> addWorkoutPlan({Workout? workoutPlan}) async {
    return await hiveService.storeWorkout(workoutPlan!);
  }

  void getWorkoutPlan() async {
    workoutPlanList.value = await hiveService.getWorkouts();
  }

  void delete(Workout workoutPlan) {
    hiveService.removeWorkout(workoutPlan.workoutId!);
    getWorkoutPlan();
  }

  void markTaskCompleted(int id) async {
    // await DBHelper.update(id);
    getWorkoutPlan();
  }
}
