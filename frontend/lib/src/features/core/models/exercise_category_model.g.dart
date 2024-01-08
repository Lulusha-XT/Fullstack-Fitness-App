// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseCategoryAdapter extends TypeAdapter<ExerciseCategory> {
  @override
  final int typeId = 1;

  @override
  ExerciseCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseCategory(
      exerciseCategoryId: fields[0] as int?,
      exerciseCategoryName: fields[1] as String,
      exerciseCategoryThumbnailImageUrl: fields[2] as String,
      exercise: (fields[3] as List?)?.cast<Exercise>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseCategory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.exerciseCategoryId)
      ..writeByte(1)
      ..write(obj.exerciseCategoryName)
      ..writeByte(2)
      ..write(obj.exerciseCategoryThumbnailImageUrl)
      ..writeByte(3)
      ..write(obj.exercise);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
