import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/features/core/screens/gym_member/gym_member.dart';
import 'package:frontend/src/features/core/screens/gym_profile/widgets/gym_post.dart';
import 'package:frontend/src/features/core/screens/gym_profile/widgets/liked_gym_post.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';

class GymProfileScreen extends StatefulWidget {
  const GymProfileScreen({super.key, required this.gym});
  final Gym gym;
  @override
  State<GymProfileScreen> createState() => _GymProfileScreenState();
}

class _GymProfileScreenState extends State<GymProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  bool slectedItem1 = true;
  bool slectedItem2 = false;
  bool slectedItem3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
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
                      // Container(
                      //   width: 2,
                      //   height: 15,
                      //   margin: EdgeInsets.symmetric(horizontal: 20),
                      //   color: AppColors.cGrey,
                      // ),
                      // makeFollowWidgets(count: 400, name: "Following"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  makeActionButtons()
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.cGrey,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              slectedItem1 = true;
                              slectedItem2 = false;
                              slectedItem3 = false;
                            });
                          },
                          child: makeTabButton("post", slectedItem1),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              slectedItem1 = false;
                              slectedItem2 = true;
                              slectedItem3 = false;
                            });
                          },
                          child: makeTabButton("like", slectedItem2),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              slectedItem1 = false;
                              slectedItem2 = false;
                              slectedItem3 = true;
                            });
                          },
                          child: makeTabButton("aboutGym", slectedItem3),
                        ),
                      ],
                    ),
                  ),
                  // makeColloction(widget.user.collocation)
                ],
              ),
            ),
          ),
          slectedItem1
              ? const GymPostWidget()
              : slectedItem2
                  ? const LikedGymPostWidget()
                  : SliverToBoxAdapter(
                      child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: makeGymInfo(),
                    )),
        ],
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

  makeTabButton(String text, bool selected) {
    return Column(
      children: [
        Text(
          text.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        selected
            ? Container(
                width: 50,
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.cOrange,
                      width: 3,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
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
                      final isLeavedGym = ref.read(gymsProvider).isLoading;

                      return isLeavedGym
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
                                    .leaveGym(widget.gym.gymId!);
                                if (success) {
                                  ref.invalidate(gymProviderProvider);
                                  ref.invalidate(gymPostsProvider);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${"youHaveLeaved".tr} ${widget.gym.gymName}!'),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${"failedToLeaved".tr} ${widget.gym.gymName}. ${"pleaseTryAgain".tr}.'),
                                    ),
                                  );
                                }
                              },
                              color: AppColors.cOrange,
                              child: Text(
                                "leave".tr,
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
