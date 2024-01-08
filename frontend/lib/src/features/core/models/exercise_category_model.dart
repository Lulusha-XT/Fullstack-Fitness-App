import 'package:frontend/config.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:hive/hive.dart';

part 'exercise_category_model.g.dart';

List<ExerciseCategory> exerciseCategoryFromJson(dynamic str) =>
    List<ExerciseCategory>.from((str).map((x) => ExerciseCategory.fromJson(x)));

@HiveType(typeId: 1)
class ExerciseCategory extends HiveObject {
  @HiveField(0)
  final int? exerciseCategoryId;
  @HiveField(1)
  final String exerciseCategoryName;
  @HiveField(2)
  final String exerciseCategoryThumbnailImageUrl;
  @HiveField(3)
  final List<Exercise>? exercise;

  ExerciseCategory({
    this.exerciseCategoryId,
    required this.exerciseCategoryName,
    required this.exerciseCategoryThumbnailImageUrl,
    this.exercise,
  });

  factory ExerciseCategory.fromJson(Map<String, dynamic> json) {
    return ExerciseCategory(
      exerciseCategoryId: json['exercise_category_id'],
      exerciseCategoryName: json['exercise_category_name'],
      exerciseCategoryThumbnailImageUrl:
          json['exercise_category_thumbnail_path'],
      exercise: exerciseFromJson(json['exercise']),
    );
  }
  ExerciseCategory copyWith({
    int? exerciseCategoryId,
    String? exerciseCategoryName,
    String? exerciseCategoryThumbnailImageUrl,
    List<Exercise>? exercise,
  }) {
    return ExerciseCategory(
      exerciseCategoryId: exerciseCategoryId ?? this.exerciseCategoryId,
      exerciseCategoryName: exerciseCategoryName ?? this.exerciseCategoryName,
      exerciseCategoryThumbnailImageUrl: exerciseCategoryThumbnailImageUrl ??
          this.exerciseCategoryThumbnailImageUrl,
      exercise: exercise ?? this.exercise,
    );
  }

  String get fullImagePath =>
      Config.imageURL + exerciseCategoryThumbnailImageUrl;
}
