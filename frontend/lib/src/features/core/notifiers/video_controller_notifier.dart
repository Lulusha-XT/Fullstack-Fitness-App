import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:frontend/src/features/core/states/video_state.dart';
import 'package:video_player/video_player.dart';

class VideoControllerNotifier extends StateNotifier<VideoState> {
  VideoControllerNotifier() : super(VideoState());
  VideoPlayerController? controller;
  Timer? _timer;
  int currentIndex = 0;

  Future<void> initialize(List<Exercise> exercise, int index) async {
    currentIndex = index;
    final assetPath = exercise[index].exerciseVideoUrl;
    controller = VideoPlayerController.asset(assetPath);
    await controller!.initialize();
    final aspectRatio = controller!.value.aspectRatio;
    state = VideoState(
      status: VideoStatus.paused,
      duration: controller!.value.duration,
      position: Duration.zero,
      exercise: exercise,
      aspectRatio: aspectRatio,
    );
    controller!.addListener(() {
      state = state.copyWith(
        duration: controller!.value.duration,
        position: controller!.value.position,
      );
    });
  }

  Future<void> play() async {
    await controller?.play();
    state = state.copyWith(status: VideoStatus.playing);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (Timer timer) {
      state = state.copyWith(position: controller!.value.position);
    });
    controller?.addListener(() {
      if (controller!.value.position == controller!.value.duration) {
        pause();
      }
    });
  }

  Future<void> pause() async {
    await controller?.pause();
    state = state.copyWith(status: VideoStatus.paused);
    _timer?.cancel();
  }

  Future<void> seekTo(Duration position) async {
    await controller?.seekTo(position);
    state = state.copyWith(position: position);
  }

  void togglePlayPause() {
    if (state.status == VideoStatus.playing) {
      pause();
    } else {
      play();
    }
  }

  void moveToNextWorkout() {
    pause();
    final exercise = state.exercise!;
    final nextIndex = currentIndex + 1;
    if (nextIndex < exercise.length) {
      initialize(exercise, nextIndex);
      play();
    } else {
      pause();
    }
  }

  void moveToPreviousWorkout() {
    pause();
    final workouts = state.exercise!;
    final previousIndex = currentIndex - 1;
    if (previousIndex >= 0) {
      initialize(workouts, previousIndex);
      play();
    } else {
      pause();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
