import 'package:frontend/config.dart';
import 'package:hive/hive.dart';

part 'exercise_model.g.dart';

List<Exercise> exerciseFromJson(dynamic str) =>
    List<Exercise>.from((str).map((x) => Exercise.fromJson(x)));

@HiveType(typeId: 2)
class Exercise extends HiveObject {
  @HiveField(0)
  int? exerciseId;
  @HiveField(1)
  String exerciseName;
  @HiveField(2)
  String exerciseThumbnail;
  @HiveField(3)
  String exerciseVideoUrl;
  @HiveField(4)
  int exerciseCategoryId;
  @HiveField(5)
  bool? isSelected;
  Exercise({
    this.exerciseId,
    required this.exerciseName,
    required this.exerciseThumbnail,
    required this.exerciseVideoUrl,
    required this.exerciseCategoryId,
    this.isSelected = false,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: json['exercise_id'],
      exerciseName: json['exercise_name'],
      exerciseThumbnail: json['exercise_thumbnail'],
      exerciseVideoUrl: json['exercise_video_path'],
      exerciseCategoryId: json['exercise_category_id'],
    );
  }
  String get fullImagePath => Config.imageURL + exerciseThumbnail;
}
