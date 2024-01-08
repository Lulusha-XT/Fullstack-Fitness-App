import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/features/core/screens/home/widgets/gym_news_widget.dart';
import 'package:frontend/src/features/core/screens/home/widgets/exercise_category.dart';
import 'package:frontend/src/features/core/screens/home/widgets/trainer_widget.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    ref.watch(staticExerciseProvider.notifier).loadExercisesFromJson();
    final exerciseCategories = ref.watch(staticExerciseProvider);
    if (exerciseCategories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: appBar("home".tr, context),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // SliverToBoxAdapter(
          //   child: SizedBox(height: 10.h),
          // ),
          // const CategoryTitle(title: "categories"),
          // ExerciseCategoryWidget(exerciseCategories: exerciseCategories),
          // SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          // const CategoryTitle(title: "forYou"),

          TrainerWidgets(),
          const CategoryTitle(title: "forYou"),
          // const GymNewsWidget(),
          SliverToBoxAdapter(child: SizedBox(height: 52.h)),
        ],
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
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
    );
  }
}
