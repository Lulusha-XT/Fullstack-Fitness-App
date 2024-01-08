import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/features/core/screens/gym_member/gym_member.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';

class GymDetaileScreen extends StatefulWidget {
  const GymDetaileScreen({super.key, required this.gym});
  final Gym gym;
  @override
  State<GymDetaileScreen> createState() => _GymDetaileScreenState();
}

class _GymDetaileScreenState extends State<GymDetaileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  Hero(
                    transitionOnUserGestures: true,
                    tag: widget.gym.gymName,
                    child: widget.gym.gymImage != null
                        ? CircleAvatar(
                            backgroundImage: AssetImage(widget.gym.gymImage!),
                            maxRadius: 40,
                          )
                        : const CircleAvatar(
                            child: Icon(Icons.sports_gymnastics),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.gym.gymName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.gym.gymName,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      makeFollowWidgets(name: "member".tr),
                    ],
                  ),
                  const SizedBox(height: 20),
                  makeActionButtons()
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.cDarkGrey,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "aboutGym".tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              width: 80,
                              padding: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.cOrange,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  makeGymInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeGymInfo() {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 2.0),
              child: Text(
                '${"monthlyPayment".tr}: ${widget.gym.gymMonthlyPayment} ${"birr".tr}',
              ),
            ),
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 2.0),
              child: Text(
                '${"gymLocation".tr}: ${widget.gym.gymLocation}',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeFollowWidgets({name}) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final gymNotifier = ref.watch(gymsProvider.notifier);

        return FutureBuilder<String>(
          future: gymNotifier.getGymUserCount(widget.gym.gymId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: AppColors.cOrange,
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final gymUserCount = snapshot.data;
              return Row(
                children: [
                  Text(
                    gymUserCount.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.cGrey,
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  Widget makeActionButtons() {
    return Transform.translate(
      offset: const Offset(0, 20),
      child: Container(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
        child: Card(
          shadowColor: AppColors.cWhiteClr,
          child: Container(
            height: 65,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final gymNotifier = ref.read(gymsProvider.notifier);
                      final isJoiningGym = ref.read(gymsProvider).isLoading;

                      return isJoiningGym
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.cOrange,
                              ),
                            )
                          : MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              height: double.infinity,
                              elevation: 0,
                              onPressed: () async {
                                final success = await gymNotifier
                                    .joinGym(widget.gym.gymId!);
                                if (success) {
                                  ref.invalidate(gymProviderProvider);
                                  ref.invalidate(gymPostsProvider);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${"youHaveJoined".tr} ${widget.gym.gymName}!'),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${"failedToJoin".tr} ${widget.gym.gymName}. ${"pleaseTryAgain".tr}.'),
                                    ),
                                  );
                                }
                              },
                              color: AppColors.cOrange,
                              child: Text(
                                "join".tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                    },
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    height: double.infinity,
                    elevation: 0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GymMemmberViewScreen(gymId: widget.gym.gymId!),
                        ),
                      );
                    },
                    color: Colors.transparent,
                    child: Text(
                      "viewMember".tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
