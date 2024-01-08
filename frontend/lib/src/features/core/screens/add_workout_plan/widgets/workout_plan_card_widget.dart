import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';
import 'package:get/get.dart';

class WorkoutPlanCardWidget extends StatelessWidget {
  const WorkoutPlanCardWidget({super.key, required this.workoutPlan});
  final Workout workoutPlan;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.h)),
        color: _getBGCLr(workoutPlan.workoutColor ?? 0),
      ),
      child: Padding(
        padding: EdgeInsets.all(13.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "yourNextWorkout".tr,
                  style: TextStyle(
                    color: AppColors.cWhiteClr,
                    fontSize: 14.h,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  workoutPlan.workoutName,
                  style: TextStyle(
                    color: AppColors.cWhiteClr,
                    fontSize: 15.h,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 7.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_tree_rounded,
                      color: Colors.grey[200],
                      size: 18.h,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "${workoutPlan.workoutStartTime}-${workoutPlan.workoutEndTime}",
                      style: TextStyle(
                        fontSize: 15.h,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 80.h,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: ListView.builder(
                    itemCount: workoutPlan.exerciseCategory!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      ExerciseCategory exerciseCategory =
                          workoutPlan.exerciseCategory![index];
                      return Padding(
                        padding: EdgeInsets.only(top: 8.0.h, right: 8.0.w),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Color(0xFFFFFFFF),
                          ),
                          padding: EdgeInsets.all(10.h),
                          child: Image.asset(
                            exerciseCategory.exerciseCategoryThumbnailImageUrl,
                            width: 50.h,
                            height: 50.h,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  workoutPlan.workoutNote ?? "",
                  style: TextStyle(
                    fontSize: 14.h,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              height: 50.h,
              width: 0.5.h,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                workoutPlan.workoutIsCompleted == 1
                    ? "completed".tr
                    : "todo".tr,
                style: TextStyle(
                  fontSize: 10.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
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
