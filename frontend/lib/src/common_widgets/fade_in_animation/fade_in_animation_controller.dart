import 'package:get/get.dart';
import 'package:frontend/src/features/authentication/screens/welcome_screen/welcome_screen.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animation = false.obs;

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animation.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    animation.value = false;
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.offAll(() => const WelcomeScreen());
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animation.value = true;
  }
}
