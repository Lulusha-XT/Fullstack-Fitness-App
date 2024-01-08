import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';

class GymMemmberViewScreen extends ConsumerStatefulWidget {
  const GymMemmberViewScreen({super.key, required this.gymId});
  final int gymId;
  @override
  ConsumerState<GymMemmberViewScreen> createState() =>
      _GymMemmberViewScreenState();
}

class _GymMemmberViewScreenState extends ConsumerState<GymMemmberViewScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "gymMember".tr,
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _buildGetData(context),
    );
  }

  Widget _buildGetData(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final gymMemberState = ref.watch(gymMemberProvider);
        if (gymMemberState.gymMember.isEmpty) {
          ref.watch(gymMemberProvider.notifier).getGymMember(widget.gymId);
          if (!gymMemberState.hasNext && !gymMemberState.isLoading) {
            return const Center(
              child: Text("No gym"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _buildBody(gymMemberState.gymMember);
        }
      },
    );
  }

  Widget _buildBody(List<UserModel> gymMember) {
    return Column(
      children: [
        // searchBox(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: gymMember.length,
              itemBuilder: (context, index) {
                final gymItem = gymMember[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => GymDetaileScreen(gym: gymMember),
                    //   ),
                    // );
                  },
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: gymItem.fullImagePath.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    gymItem.fullImagePath,
                                  ),
                                  radius: 25,
                                )
                              : const Icon(Icons.person),
                          title: Text(gymItem.fullName),
                          subtitle: const Padding(
                            padding: EdgeInsets.only(left: 8.0, top: 2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //   Text(
                                //     '${"Monthly Payment".tr}: ${gymItem.gymMonthlyPayment} "birr"',
                                //   ),
                                //   Text(
                                //       '${"Gym Location".tr}: ${gymItem.gymLocation}, '),
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
