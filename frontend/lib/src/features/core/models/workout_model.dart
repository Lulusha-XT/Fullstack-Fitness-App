import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:hive/hive.dart';

part 'workout_model.g.dart';

List<Workout> workoutFromJson(dynamic str) =>
    List<Workout>.from((str).map((x) => Workout.fromJson(x)));

@HiveType(typeId: 0)
class Workout extends HiveObject {
  @HiveField(0)
  int? workoutId;
  @HiveField(1)
  String workoutName;
  @HiveField(2)
  String? workoutNote;
  @HiveField(3)
  int? workoutIsCompleted;
  @HiveField(4)
  String? workoutDate;
  @HiveField(5)
  String? workoutStartTime;
  @HiveField(6)
  String? workoutEndTime;
  @HiveField(7)
  int? workoutColor;
  @HiveField(8)
  int? workoutRemind;
  @HiveField(9)
  String? workoutRepeat;
  @HiveField(10)
  List<ExerciseCategory>? exerciseCategory;

  Workout({
    this.workoutId,
    required this.workoutName,
    this.workoutNote,
    this.workoutIsCompleted,
    this.workoutDate,
    this.workoutStartTime,
    this.workoutEndTime,
    this.workoutColor,
    this.workoutRemind,
    this.workoutRepeat,
    this.exerciseCategory,
  });
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      workoutId: json['key'],
      workoutName: json['workout_name'],
      workoutNote: json['workoutNote'],
      workoutIsCompleted: json['workoutIsCompleted'],
      workoutDate: json['workoutDate'],
      workoutStartTime: json['workoutStartTime'],
      workoutEndTime: json['workoutEndTime'],
      workoutColor: json['workoutColor'],
      workoutRemind: json['workoutRemind'],
      workoutRepeat: json['workoutRepeat'],
      exerciseCategory: json['exercise_category_list'],
    );
  }
}
