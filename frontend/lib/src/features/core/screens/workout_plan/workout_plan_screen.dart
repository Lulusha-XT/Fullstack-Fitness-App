import 'package:animations/animations.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/controllers/workout_plan_controller.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';
import 'package:frontend/src/features/core/screens/add_workout_plan/add_workout_plan_screen.dart';
import 'package:frontend/src/features/core/screens/add_workout_plan/widgets/workout_plan_card_widget.dart';
import 'package:frontend/src/utils/notification_services.dart';
import 'package:frontend/src/utils/themes/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'workout_plan_detail/workout_plan_detail_screen.dart';

class WorkoutPlanScreen extends StatefulWidget {
  const WorkoutPlanScreen({super.key});

  @override
  State<WorkoutPlanScreen> createState() => _WorkoutPlanScreenState();
}

class _WorkoutPlanScreenState extends State<WorkoutPlanScreen> {
  var notifiyHelper = NotifiyHelper();
  int slectedItem = 2;
  DateTime _selectedDate = DateTime.now();
  final workoutPlanController = Get.put(WorkoutPlanController());

  @override
  void initState() {
    super.initState();
    notifiyHelper.InitializNotification();
    notifiyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    workoutPlanController.getWorkoutPlan();
    return Scaffold(
      appBar: appBar("workoutPlan".tr, context),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            _addWorkoutPlanBar(),
            _addDateBar(),
            const SizedBox(height: 10),
            showWorkoutPlan(context),
          ],
        ),
      ),
    );
  }

  showWorkoutPlan(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: workoutPlanController.workoutPlanList.length,
            itemBuilder: (_, index) {
              Workout workoutPlan =
                  workoutPlanController.workoutPlanList[index];
              print(
                  "Workout Star Time ${workoutPlan.workoutStartTime.toString()}");
              if (workoutPlan.workoutRepeat == 'Daily') {
                String? hourMinit = workoutPlan.workoutStartTime?.split(" ")[0];
                print(hourMinit);
                // DateTime date = DateFormat.jm().parse(hourMinit!);
                // var myTime = DateFormat("HH:mm").format(date);
                notifiyHelper.scheduledNotification(
                  int.parse(hourMinit.toString().split(":")[0]),
                  int.parse(hourMinit.toString().split(":")[1]),
                  workoutPlan,
                );
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: workoutPlanController.workoutPlanList.length,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          OpenContainer(
                            closedColor: Colors.transparent,
                            openColor: Colors.transparent,
                            closedElevation: 0,
                            transitionType: ContainerTransitionType.fade,
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                            openBuilder: (context, _) {
                              return WorkoutPlanDetailScreen(
                                  workout: workoutPlan);
                            },
                            closedBuilder:
                                (context, VoidCallback openContainer) {
                              return GestureDetector(
                                onTap: openContainer,
                                child: WorkoutPlanCardWidget(
                                  workoutPlan: workoutPlan,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (workoutPlan.workoutDate ==
                  DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: workoutPlanController.workoutPlanList.length,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          OpenContainer(
                            closedColor: Colors.transparent,
                            openColor: Colors.transparent,
                            closedElevation: 0,
                            transitionType: ContainerTransitionType.fade,
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                            openBuilder: (context, _) {
                              return WorkoutPlanDetailScreen(
                                  workout: workoutPlan);
                            },
                            closedBuilder:
                                (context, VoidCallback openContainer) {
                              return GestureDetector(
                                onTap: openContainer,
                                child: WorkoutPlanCardWidget(
                                  workoutPlan: workoutPlan,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: AppColors.cOrange,
        selectedTextColor: AppColors.cWhiteClr,
        dateTextStyle: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addWorkoutPlanBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "today".tr,
                  style: headingStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Get.to(() => const AddWorkoutPlanScreen());
              workoutPlanController.getWorkoutPlan();
            },
            child: Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.cOrange,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "addWorkoutPlan".tr,
                    style: const TextStyle(
                      color: AppColors.cWhiteClr,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context, Workout workoutPlan) {
    Get.bottomSheet(
      Container(
        height: workoutPlan.workoutIsCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        padding: const EdgeInsets.only(top: 4),
        color: Get.isDarkMode
            ? AppColors.cSecondaryColor
            : AppColors.cPrimaryColor,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const Spacer(),
            workoutPlan.workoutIsCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "taskComplet".tr,
                    onTap: () {
                      workoutPlanController
                          .markTaskCompleted(workoutPlan.workoutId!);
                      Get.back();
                    },
                    clr: AppColors.cOrange,
                    context: context,
                  ),
            const SizedBox(height: 20),
            _bottomSheetButton(
              label: "deleteWorkoutPlan".tr,
              onTap: () {
                // workoutPlanController.delete(workoutPlan);
                Get.back();
              },
              clr: Colors.red[300],
              context: context,
            ),
            const SizedBox(height: 20),
            _bottomSheetButton(
              label: "close".tr,
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300],
              isClosed: true,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton(
      {String? label,
      Function()? onTap,
      Color? clr,
      bool isClosed = false,
      BuildContext? context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context!).size.width * 0.9,
        decoration: BoxDecoration(
          color: isClosed == true
              ? Get.isDarkMode
                  ? Colors.grey[60]
                  : Colors.grey[300]
              : clr!,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label!,
            style: isClosed
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
