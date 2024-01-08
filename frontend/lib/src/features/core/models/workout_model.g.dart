// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final int typeId = 0;

  @override
  Workout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Workout(
      workoutId: fields[0] as int?,
      workoutName: fields[1] as String,
      workoutNote: fields[2] as String?,
      workoutIsCompleted: fields[3] as int?,
      workoutDate: fields[4] as String?,
      workoutStartTime: fields[5] as String?,
      workoutEndTime: fields[6] as String?,
      workoutColor: fields[7] as int?,
      workoutRemind: fields[8] as int?,
      workoutRepeat: fields[9] as String?,
      exerciseCategory: (fields[10] as List).cast<ExerciseCategory>(),
    );
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.workoutId)
      ..writeByte(1)
      ..write(obj.workoutName)
      ..writeByte(2)
      ..write(obj.workoutNote)
      ..writeByte(3)
      ..write(obj.workoutIsCompleted)
      ..writeByte(4)
      ..write(obj.workoutDate)
      ..writeByte(5)
      ..write(obj.workoutStartTime)
      ..writeByte(6)
      ..write(obj.workoutEndTime)
      ..writeByte(7)
      ..write(obj.workoutColor)
      ..writeByte(8)
      ..write(obj.workoutRemind)
      ..writeByte(9)
      ..write(obj.workoutRepeat)
      ..writeByte(10)
      ..write(obj.exerciseCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
