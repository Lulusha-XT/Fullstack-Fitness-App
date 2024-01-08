import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/controllers/update_profile_controller.dart';
import 'package:get/get.dart';

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier(this._apiService)
      : super(UserModel(email: '', fullName: '', phoneNo: ''));
  final ApiService _apiService;
  final controllers = Get.put(UpdateProfileController());
  Future<void> getUser() async {
    final user = await _apiService.getUsersData();

    state = user!;
    print("user $user");
  }

  Future<bool> updateUserInfo(UserModel user, File? imageFile) async {
    print("It comming");
    final updatedUser = await _apiService.updateProfile(user, imageFile);
    if (updatedUser) {
      final user = await _apiService.getUsersData();
      state = user!;
      controllers.isAsyncCallProcess = false.obs;
      return true;
    }
    return false;
  }

  // Future<void> reset() async {
  //   Future.delayed(const Duration(microseconds: 1500), () {
  //     state = UserModel(
  //       bloodType: '',
  //       email: '',
  //       fullName: '',
  //       phoneNo: '',
  //     );
  //   });
  // }
}
