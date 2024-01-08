import 'package:flutter/material.dart';
import 'package:frontend/src/features/core/screens/book/book_screen.dart';
import 'package:frontend/src/features/core/screens/find_gym/gym_display_screen.dart';
import 'package:frontend/src/features/core/screens/home/home_page.dart';
import 'package:frontend/src/features/core/screens/profile/profile_screen.dart';
import 'package:frontend/src/features/core/screens/workout_plan/workout_plan_screen.dart';
import 'package:get/get.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final List<Widget> _pageList = [
    const HomeScreen(),
    const GymListViewScreen(),
    const WorkoutPlanScreen(),
    //const BookScreen(),
    const ProfileScreen(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.home),
              ),
              label: "home".tr,
            ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.fitness_center),
              ),
              label: "findGym".tr,
            ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.calendar_today),
              ),
              label: "workoutPlan".tr,
            ),
            // BottomNavigationBarItem(
            //   icon: const Padding(
            //     padding: EdgeInsets.only(top: 8.0),
            //     child: Icon(Icons.book),
            //   ),
            //   label: "book".tr,
            // ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.person),
              ),
              label: "profile".tr,
            ),
          ],
        ),
      ),
    );
  }
}
