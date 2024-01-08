import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:frontend/src/features/core/screens/home/widgets/exercise_list.dart';
import 'package:frontend/src/features/core/states/video_state.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoDisplayWidget extends ConsumerStatefulWidget {
  const VideoDisplayWidget({super.key, required this.exercise});
  final List<Exercise> exercise;
  @override
  ConsumerState<VideoDisplayWidget> createState() => _VideoDisplayWidgetState();
}

class _VideoDisplayWidgetState extends ConsumerState<VideoDisplayWidget> {
  List<Exercise> exercise = [];
  @override
  void initState() {
    super.initState();
    exercise = widget.exercise;
    final controller = ref.read(videoControllerProvider.notifier);
    controller.initialize(exercise, 0);
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoControllerProvider);
    final videoController = ref.watch(videoControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "workout".tr,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: videoState.exercise == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.cWhiteClr,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: videoState.aspectRatio!,
                        child: VideoPlayer(videoController.controller!),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.skip_previous),
                                onPressed: () {
                                  videoController.moveToPreviousWorkout();
                                },
                                color: Colors.black,
                              ),
                              IconButton(
                                icon: videoState.status == VideoStatus.playing
                                    ? const Icon(Icons.pause)
                                    : const Icon(Icons.play_arrow),
                                onPressed: videoController.togglePlayPause,
                                color: Colors.black,
                              ),
                              IconButton(
                                icon: const Icon(Icons.skip_next),
                                onPressed: () {
                                  videoController.moveToNextWorkout();
                                },
                                color: Colors.black,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                '${videoState.position?.inMinutes.toString().padLeft(2, '0')}:${(videoState.position!.inSeconds % 60).toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${videoState.duration?.inMinutes.toString().padLeft(2, '0')}:${(videoState.duration!.inSeconds % 60).toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                ExerciseList(exerciseList: exercise),
              ],
            ),
    );
  }
}
