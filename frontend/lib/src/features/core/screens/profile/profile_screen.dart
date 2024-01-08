import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/models/meal_model.dart';
import 'package:frontend/src/features/core/screens/food_display/food_display_screen.dart';
import 'package:frontend/src/features/core/screens/profile/widgets/body_measurement_view.dart';
import 'package:frontend/src/features/core/screens/profile/update_profile_screen/updat_profile_screen.dart';
import 'package:frontend/src/features/core/screens/profile/widgets/ingredient_progress.dart';
import 'package:frontend/src/features/core/screens/profile/widgets/meal_card.dart';
import 'package:frontend/src/features/core/screens/profile/widgets/radial_progress.dart';
import 'package:frontend/src/features/core/services/user_service.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:frontend/src/utils/assets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _userData(context),
    );
  }

  Widget _userData(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final user = ref.watch(userProvider);
        if (user.id == null) {
          // fetch user data
          ref.read(userProvider.notifier).getUser();
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // show user profile page
          return ProfileWidget(user: user);
        }
      },
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final double tdee = UserService.calculateTDEE(
      user.weight!,
      user.height!,
      user.age!,
      user.gender!,
      user.activityExtent!,
    ) /* Calculate TDEE based on your specific formula */;
    // Calculate daily macronutrient requirements
    final macronutrientsData =
        UserService.calculateMacronutrients(tdee, user.aim!);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final today = DateTime.now();

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            height: height * 0.38,
            left: 0,
            right: 0,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 40, left: 25, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "${"hello".tr}, ${user.fullName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Get.to(() => UpdateProfileScreen(user: user));
                        },
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: user.profilePicture!.isNotEmpty
                                ? Image.network(
                                    user.fullImagePath,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    AssetsImages.userJpg,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RadialProgress(
                            width: width * 0.32,
                            height: width * 0.32,
                            progress: 0.7,
                            result: tdee,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IngredientProgress(
                                ingredient: "protein".tr,
                                progress: 0.3,
                                progressColor: Colors.green,
                                leftAmount: macronutrientsData
                                    .macronutrientProtein
                                    .toInt(),
                                width: width * 0.28,
                              ),
                              const SizedBox(height: 10),
                              IngredientProgress(
                                ingredient: "carbs".tr,
                                progress: 0.2,
                                progressColor: Colors.red,
                                leftAmount: macronutrientsData
                                    .macronutrientCarbohydrates
                                    .toInt(),
                                width: width * 0.28,
                              ),
                              const SizedBox(height: 10),
                              IngredientProgress(
                                ingredient: "fat".tr,
                                progress: 0.1,
                                progressColor: Colors.yellow,
                                leftAmount:
                                    macronutrientsData.macronutrientFat.toInt(),
                                width: width * 0.28,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.4,
            left: 0,
            right: 0,
            child: SizedBox(
              height: height * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10.0, bottom: 10.0),
                        child: Text(
                          "mealForToday".tr,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodListViewScreen(
                                    macronutrientsData: macronutrientsData),
                              ),
                            );
                          },
                          child: Text(
                            "foodList".tr,
                            style: const TextStyle(
                              color: AppColors.cOrange,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        return MealCard(
                          meal: meals[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(child: BodyMeasurementView(user: user)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
