import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';

class WelcomeController extends GetxController {
  static WelcomeController get instance => Get.find();

  String? exercise;
  String? aim;
  RxInt height = 180.obs;
  RxInt weight = 60.obs;
  RxBool hidePassword = true.obs;
  RxBool isAsyncCallProcess = false.obs;
  final TextEditingController birthdayController = TextEditingController();

  Future<bool> registerMoreUserInfo(UserModel user) async {
    ApiService apiService = ApiService();
    bool result = await apiService.updateProfile(user, null);
    return result;
  }
}
