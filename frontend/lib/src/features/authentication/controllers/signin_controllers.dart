import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:get/get.dart';

class SignInControllers extends GetxController {
  static SignInControllers get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  RxBool hidePassword = true.obs;
  RxBool isAsyncCallProcess = false.obs;

  Future<bool> signInUser(String email, String password) async {
    // AuthenticationRepository.instance.signInUserWithEmailAndPassword(email, password);

    bool result = await ApiService.login(email, password);
    isAsyncCallProcess.value = false;
    return result;
  }
}
