import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/common_widgets/profile_avater/profile_avater.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/controllers/update_profile_controller.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:frontend/src/utils/assets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(UpdateProfileController());
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final user = ref.watch(userProvider);
        return Stack(
          children: [
            user.profilePicture!.isEmpty
                ? const CircleAvatarWithTransition(
                    image: AssetImage(AssetsImages.userJpg),
                    primaryColor: AppColors.cOrange,
                    size: 130,
                    transitionBorderwidth: 1.0,
                  )
                : CircleAvatarWithTransition(
                    image: NetworkImage(user.fullImagePath),
                    primaryColor: AppColors.cOrange,
                    size: 130,
                    transitionBorderwidth: 1.0,
                  ),
            Positioned(
              bottom: 5,
              right: 5,
              child: CircleAvatar(
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: IconButton(
                    icon: const Icon(
                      LineAwesomeIcons.camera,
                      size: 20,
                    ),
                    onPressed: () async {
                      //  pick imaGe
                      // install image_picker
                      // import the corresponding library
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                        source: ImageSource.camera,
                      );
                      print("${file?.path}");
                      if (file == null) return;
                      controllers.imageFile.value = File(file.path);
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
