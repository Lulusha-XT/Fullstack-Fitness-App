import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/features/core/screens/find_gym/gym_detail/gym_detail.dart';
import 'package:frontend/src/features/core/screens/find_gym/gym_detail/gym_detailsa_screen.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';

class GymListViewScreen extends ConsumerStatefulWidget {
  const GymListViewScreen({super.key});

  @override
  ConsumerState<GymListViewScreen> createState() => _GymListViewScreenState();
}

class _GymListViewScreenState extends ConsumerState<GymListViewScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("gymList".tr, context),
      body: _buildGetData(context),
    );
  }

  Widget _buildGetData(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final gymState = ref.watch(gymsProvider);
        if (gymState.gyms.isEmpty) {
          ref.watch(gymsProvider.notifier).getGyms();
          if (!gymState.hasNext && !gymState.isLoading) {
            return const Center(
              child: Text("No gym"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _buildBody(gymState.gyms);
        }
      },
    );
  }

  Widget _buildBody(List<Gym> gyms) {
    return Column(
      children: [
        // searchBox(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: gyms.length,
              itemBuilder: (context, index) {
                final gymItem = gyms[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GymDetalScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: gymItem.gymImage != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    gymItem.gymImage!,
                                  ),
                                  radius: 25,
                                )
                              : const Icon(Icons.sports_gymnastics),
                          title: Text(gymItem.gymName),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${"monthlyPayment".tr}: ${gymItem.gymMonthlyPayment} ${"birr".tr}',
                                ),
                                Text(
                                  '${"gymLocation".tr}: ${gymItem.gymLocation}',
                                ),
                              ],
                            ),
                          ),
                          // trailing: GestureDetector(
                          //   onTap: () {
                          //    // toggleItemSelection(index);
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: foodItem.isSelected
                          //           ? Colors.green
                          //           : Colors.grey,
                          //       borderRadius: BorderRadius.circular(50),
                          //     ),
                          //     child: const Icon(
                          //       Icons.check,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            "bestPlaceToFindGym".tr,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Card(
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "search".tr,
                      ),
                      onChanged: (value) {
                        setState(
                          () {
                            // Filter the nutritionItems based on the search query
                            // nutritionItems = data
                            //     .map((item) => FoodModel.fromJson(item))
                            //     .where((item) => item.name
                            //         .toLowerCase()
                            //         .contains(value.toLowerCase()))
                            //     .toList();
                          },
                        );
                      },
                      maxLines: 1,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: double.infinity,
                    minWidth: 50,
                    elevation: 0,
                    color: AppColors.cOrange,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
