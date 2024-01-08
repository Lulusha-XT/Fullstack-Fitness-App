import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:frontend/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:frontend/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/image_strings.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/features/authentication/screens/signin_screen/signin_screen.dart';
import 'package:frontend/src/features/authentication/screens/signup_screen/signup_screen.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();
    var mediaQuery = MediaQuery.of(context);
    var brightnes = mediaQuery.platformBrightness;
    var height = mediaQuery.size.height;
    final isDarkMode = brightnes == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.cSecondaryColor : AppColors.cWhiteColor,
      body: Stack(
        children: [
          CFadeInAnimation(
            durationInMs: 2000,
            animatePositionModel: CAnimationPositionModel(
              bottomBefore: -100,
              bottomAfter: 0,
              topBefore: 0,
              topAfter: 0,
              leftBefore: 0,
              leftAfter: 0,
              rightBefore: 0,
              rigthAfter: 0,
            ),
            child: Container(
              padding: const EdgeInsets.all(cDefaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: const AssetImage(cAppLogoImage),
                    height: height * 0.6,
                    color:
                        isDarkMode ? AppColors.cWhiteClr : AppColors.cDarkColor,
                  ),
                  Column(
                    children: [
                      Text(
                        "welcomeTitle".tr,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "welcomeSubtitle".tr,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => const SigninScreen());
                          },
                          child: Text(
                            "signIn".tr,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                          child: Text(
                            "signUp".tr,
                            style: const TextStyle(
                              color: AppColors.cWhiteClr,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
