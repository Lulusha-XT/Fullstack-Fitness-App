import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';

class ExerciseList extends ConsumerWidget {
  const ExerciseList({
    super.key,
    required this.exerciseList,
  });

  final List<Exercise> exerciseList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "categories".tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
        SizedBox(
          height: 170.h,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 24.w),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemCount: exerciseList.length,
            itemBuilder: (context, index) {
              final exercise = exerciseList[index];
              return GestureDetector(
                onTap: () {
                  final controller = ref.read(videoControllerProvider.notifier);
                  controller.initialize(exerciseList, index);
                  controller.play();
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        width: 150.w,
                        height: 170.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage(
                              exercise.exerciseThumbnail,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 39.h,
                                color: const Color(0xff525252),
                                child: Center(
                                  child: Text(
                                    exercise.exerciseName.tr,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 17.w,
              );
            },
          ),
        ),
      ],
    );
  }
}
