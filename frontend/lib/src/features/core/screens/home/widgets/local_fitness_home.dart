import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/screens/home/local_excercise_screen.dart';

class LocalExerciseCategoryWidget extends StatefulWidget {
  const LocalExerciseCategoryWidget({super.key});

  @override
  State<LocalExerciseCategoryWidget> createState() =>
      _LocalExerciseCategoryWidgetState();
}

class _LocalExerciseCategoryWidgetState
    extends State<LocalExerciseCategoryWidget> {
  List<ExerciseCategory> exerciseCategory = [];

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/excercise.json")
        .then((value) {
      setState(() {
        List videoInfo = json.decode(value);
        exerciseCategory = videoInfo
            .map(
              (json) => ExerciseCategory(
                exerciseCategoryId: json["excercise_category_id"],
                exerciseCategoryName: json['excercise_category_name'],
                exerciseCategoryThumbnailImageUrl:
                    json['excercise_category_thumbnail_path'],
                exercise: exerciseFromJson(json['excercise']),
              ),
            )
            .toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: _buildCard(),
          ),
        ],
      ),
    );
  }

  _buildCard() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: double.infinity,
            height: 170.h,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 15.w),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10.w,
                );
              },
              itemCount: exerciseCategory.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocalExcerciseScreen(
                                excerciseCategory: exerciseCategory[index],
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            width: 150.w,
                            height: 170.h,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                image: AssetImage(
                                  exerciseCategory[index]
                                      .exerciseCategoryThumbnailImageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 30),
                                ),
                              ],
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
                                        exerciseCategory[index]
                                            .exerciseCategoryName,
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
