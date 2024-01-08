import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/database/hive_service.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:frontend/src/features/core/screens/home/widgets/video_play_widgets.dart';
import 'package:get/get.dart';

class WorkoutExerciseExpandableListItem extends StatefulWidget {
  const WorkoutExerciseExpandableListItem(
      {super.key, required this.exerciseCategory, required this.workoutColor});

  final ExerciseCategory exerciseCategory;
  final int workoutColor;
  @override
  State<WorkoutExerciseExpandableListItem> createState() =>
      _WorkoutExerciseExpandableListItemState();
}

class _WorkoutExerciseExpandableListItemState
    extends State<WorkoutExerciseExpandableListItem> {
  bool isExpanded = false;
  late List<Exercise> exerciseItem;

  @override
  void initState() {
    exerciseItem = widget.exerciseCategory.exercise!;
    super.initState();
  }

  void toggleItemSelection(int index) {
    setState(() {
      final hiveService = HiveService();
      exerciseItem[index].isSelected = !exerciseItem[index].isSelected!;

      if (exerciseItem[index].isSelected!) {
        hiveService.storeExercise(exerciseItem[index]);
      } else {
        hiveService.removeExercise(exerciseItem[index].exerciseId!);
      }

      final selectedExercises =
          exerciseItem.where((exercise) => exercise.isSelected!).toList();
      final updatedExerciseCategory = ExerciseCategory(
        exerciseCategoryId: widget.exerciseCategory.exerciseCategoryId,
        exerciseCategoryName: widget.exerciseCategory.exerciseCategoryName,
        exerciseCategoryThumbnailImageUrl:
            widget.exerciseCategory.exerciseCategoryThumbnailImageUrl,
        exercise: selectedExercises,
      );

      hiveService.storeExerciseCategory(updatedExerciseCategory);
      hiveService.clearExercise();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ExpansionTile(
        backgroundColor: _getBGCLr(widget.workoutColor),
        textColor: AppColors.cWhiteClr,
        collapsedTextColor: AppColors.cWhiteClr,
        collapsedBackgroundColor: _getBGCLr(widget.workoutColor),
        leading: CircleAvatar(
          backgroundImage: ExactAssetImage(
            widget.exerciseCategory.exerciseCategoryThumbnailImageUrl,
          ),
          radius: 25,
        ),
        title: Text(
          widget.exerciseCategory.exerciseCategoryName.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: exerciseItem.length,
            itemBuilder: (context, index) {
              final exercise = exerciseItem[index];
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 0.2,
                        offset: Offset(0.3, 0.5),
                        spreadRadius: 0.5,
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      //      final controller = ref.read(videoControllerProvider.notifier);
                      // controller.initialize(exercise.exercise!, 1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoDisplayWidget(exercise: exerciseItem),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            ExactAssetImage(exercise.exerciseThumbnail),
                        radius: 25,
                      ),
                      title: Text(
                        exercise.exerciseName.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: const Text(
                        '12 reps, 4 sets',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _getBGCLr(int no) {
    switch (no) {
      case 0:
        return AppColors.cOrange;
      case 1:
        return AppColors.cPinkClr;
      case 2:
        return AppColors.cYellowClr;
      default:
        return AppColors.cOrange;
    }
  }
}
