import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/food_model.dart';
import 'package:frontend/src/features/core/models/macronutrient_model.dart';
import 'package:get/get.dart';

class FoodListViewScreen extends StatefulWidget {
  const FoodListViewScreen({Key? key, required this.macronutrientsData})
      : super(key: key);
  final Macronutrient macronutrientsData;

  @override
  _FoodListViewScreenState createState() => _FoodListViewScreenState();
}

class _FoodListViewScreenState extends State<FoodListViewScreen> {
  TextEditingController searchController = TextEditingController();
  List<FoodModel> nutritionItems = [];
  List<FoodModel> selectedItems = [];
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    loadFoodData();
  }

  Future<void> loadFoodData() async {
    String jsonData = await rootBundle.loadString('json/food_data.json');
    data = jsonDecode(jsonData);

    setState(() {
      nutritionItems = data.map((item) => FoodModel.fromJson(item)).toList();
    });
  }

  void toggleItemSelection(int index) {
    setState(() {
      nutritionItems[index].isSelected = !nutritionItems[index].isSelected;

      if (nutritionItems[index].isSelected) {
        selectedItems.add(nutritionItems[index]);
      } else {
        selectedItems.remove(nutritionItems[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "foodList".tr,
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "search".tr,
                  suffixIcon: MaterialButton(
                    onPressed: () {
                      searchController.clear();
                      setState(
                        () {
                          // Clear the search results
                          nutritionItems = data
                              .map((item) => FoodModel.fromJson(item))
                              .toList();
                        },
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: double.infinity,
                    minWidth: 70,
                    elevation: 0,
                    color: AppColors.cOrange,
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      // Filter the nutritionItems based on the search query
                      nutritionItems = data
                          .map((item) => FoodModel.fromJson(item))
                          .where((item) => item.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    },
                  );
                },
                maxLines: 1,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: nutritionItems.length,
                itemBuilder: (context, index) {
                  final foodItem = nutritionItems[index];
                  return Column(
                    children: [
                      const SizedBox(height: 15),
                      Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: ExactAssetImage(
                              foodItem.imageUrl,
                            ),
                            radius: 25,
                          ),
                          title: Text(foodItem.name),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${"carbs".tr}: ${foodItem.carbohydrates}g, ',
                                ),
                                Text('${"protein".tr}: ${foodItem.protein}g, '),
                                Text('${"fat".tr}: ${foodItem.fat}g'),
                              ],
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              toggleItemSelection(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: foodItem.isSelected
                                    ? Colors.green
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle displaying selected items and grams needed
          displayFoodSize();
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }

  void displayFoodSize() {
    final carbohydrates = widget.macronutrientsData.macronutrientCarbohydrates;
    final protein = widget.macronutrientsData.macronutrientProtein;
    final fat = widget.macronutrientsData.macronutrientFat;

    List<double> sizes = calculateFoodSize(carbohydrates, protein, fat);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Items and Grams Needed'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < selectedItems.length; i++)
                ListTile(
                  title: Text(selectedItems[i].name),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${"gramsNeeded".tr}: ${sizes[i].toStringAsFixed(2)} kg'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('close'.tr),
            ),
          ],
        );
      },
    );
  }

  List<double> calculateFoodSize(
      double carbohydrates, double protein, double fat) {
    final len = selectedItems.length;
    final ch = (carbohydrates != 0) ? carbohydrates / len : 0.0;
    final pr = (protein != 0) ? protein / len : 0.0;
    final fa = (fat != 0) ? fat / len : 0.0;
    final arr = <double>[];

    for (final foodItem in selectedItems) {
      final gram1 =
          (foodItem.carbohydrates != 0) ? (ch / foodItem.carbohydrates) : 0.0;
      final gram2 = (foodItem.protein != 0) ? (pr / foodItem.protein) : 0.0;
      final gram3 = (foodItem.fat != 0) ? (fa / foodItem.fat) : 0.0;

      // Calculate gramsNeeded independently for each macronutrient
      final gramsNeeded = (gram1 + gram2 + gram3) / 1000;

      final multiplier = (foodItem.isSeasoning) ? 0.1 : 1.0;
      arr.add(gramsNeeded * multiplier);
    }
    return arr;
  }
}
