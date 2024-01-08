import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    print(label.toString().split("|")[0]);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          label.toString().split("|")[0],
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 280,
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.isDarkMode ? Colors.white : Colors.black38,
              ),
              child: Center(
                child: Text(
                  label.toString().split("|")[1],
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.black : Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: GestureDetector(
              onTap: () {
                //  Get.to(() => const Home());
              },
              child: Container(
                height: 50,
                width: 330,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.cOrange,
                ),
                child: const Center(
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      color: AppColors.cWhiteClr,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
