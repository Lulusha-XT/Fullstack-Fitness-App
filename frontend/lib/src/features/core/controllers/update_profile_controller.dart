import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();

  final fullname = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final birthdayController = TextEditingController();
  String? gender;
  String? aim;
  String? activityExtent;

  final hidePassword = true.obs;
  RxBool isAsyncCallProcess = false.obs;

  final imageFile = Rx<File?>(null);

  void reset() {
    fullname.text = '';
    height.text = '';
    weight.text = '';
    email.text = '';
    phoneNo.text = '';
    hidePassword.value = true;
    imageFile.value = null;
  }
}
