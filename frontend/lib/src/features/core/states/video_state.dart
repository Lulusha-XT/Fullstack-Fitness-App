import 'dart:ui';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:video_player/video_player.dart';

enum VideoStatus { playing, paused }

class VideoState {
  VideoStatus? status;
  Duration? duration;
  Duration? position;
  List<Exercise>? exercise;
  double? aspectRatio;

  VideoState({
    this.status,
    this.duration,
    this.position,
    this.exercise,
    this.aspectRatio,
  });

  VideoState copyWith({
    VideoStatus? status,
    Duration? duration,
    Duration? position,
    List<Exercise>? exercise,
    double? aspectRatio,
  }) {
    return VideoState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      exercise: exercise ?? this.exercise,
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }

  VideoPlayerValue toVideoPlayerValue() {
    return VideoPlayerValue(
      duration: duration!,
      size: Size(aspectRatio! * 100, 100),
      position: position!,
      buffered: [],
    );
  }
}
