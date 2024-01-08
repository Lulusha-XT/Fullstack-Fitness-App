import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/form/form_header_widget.dart';
import 'package:frontend/src/constants/image_strings.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/features/authentication/screens/signin_screen/signin_screen.dart';
import 'package:frontend/src/features/authentication/screens/signup_screen/widgets/signup_form_widget.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: cDefaultSize,
            right: cDefaultSize,
            bottom: cDefaultSize,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormHeaderWidget(
                image: cAppLogoImage,
                title: "signUpTitle".tr,
                subTitle: "signUpSubTitle".tr,
              ),
              const SizedBox(height: cDefaultSize - 10),
              const SignUpFormWidget(),
              const SizedBox(height: cDefaultSize - 10),
              Column(
                children: [
                  Center(child: Text("or".tr)),
                  const SizedBox(height: cDefaultSize - 10),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SigninScreen());
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "alreadyHaveAnAccount".tr,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(text: "signIn".tr),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
