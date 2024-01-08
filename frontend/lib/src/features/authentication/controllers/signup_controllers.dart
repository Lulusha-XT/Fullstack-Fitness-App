import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:get/get.dart';

class SignUpControllers extends GetxController {
  static SignUpControllers get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final phoneNo = TextEditingController();
  String? gender;
  RxBool hidePassword = true.obs;
  RxBool isAsyncCallProcess = false.obs;
  //final userRepo = Get.put(UserRepository());
  //Call this Function from Design & it will do the rest
  void registerUser(String email, String password) {
    // AuthenticationRepository.instance .createUserWithEmailAndPassword(email, password);
  }
  Future<bool> createUser(UserModel user) async {
    bool result = await ApiService.registerUser(user);
    isAsyncCallProcess.value = false;
    return result;
  }
}
