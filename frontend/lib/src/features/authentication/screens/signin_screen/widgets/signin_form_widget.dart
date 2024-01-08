import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/circularProgressBar/circular_progress_widget.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/features/authentication/controllers/signin_controllers.dart';
import 'package:frontend/src/features/core/screens/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(SignInControllers());
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: cFormHeigth - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controllers.email,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: "email".tr,
                hintText: "email".tr,
                border: const OutlineInputBorder(),
              ),
              validator: (value) => validateEmail(value),
            ),
            const SizedBox(height: cFormHeigth - 10),
            Obx(
              () => TextFormField(
                controller: controllers.password,
                decoration: InputDecoration(
                  label: Text("password".tr),
                  prefixIcon: const Icon(Icons.key_outlined),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controllers.hidePassword.value =
                          !controllers.hidePassword.value;
                    },
                    color: Colors.redAccent.withOpacity(.4),
                    icon: Icon(
                      controllers.hidePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) => validatePassword(value, "password".tr),
                obscureText: controllers.hidePassword.value,
              ),
            ),
            const SizedBox(height: cFormHeigth),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: () {
            //       //  ForgetPasswordScreen.buildShowModalBottomSheet(context);
            //     },
            //     child: Text(cForgetPassword),
            //   ),
            // ),
            Obx(
              () => controllers.isAsyncCallProcess.value
                  ? Center(
                      child: DottedCircularProgressIndicatorFb(
                        currentDotColor: Colors.white,
                        defaultDotColor: AppColors.cOrange,
                        numDots: 8,
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            controllers.isAsyncCallProcess.value = true;
                            try {
                              await SignInControllers.instance.signInUser(
                                      controllers.email.text.trim(),
                                      controllers.password.text.trim())
                                  ?
                                  // If the Logged-In was successful
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("fitnessApp".tr),
                                          content: Text(
                                              "loginSuccessfulySubTitle".tr),
                                          actions: [
                                            TextButton(
                                              child: Text("ok".tr),
                                              onPressed: () {
                                                // Navigator.of(context).pop();
                                                // Navigator.of(context)
                                                //     .pushNamedAndRemoveUntil(
                                                //   "/login",
                                                //   (route) => false,
                                                // );
                                                Get.to(() =>
                                                    const DashBoardScreen());
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  // If the email is already registered
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("fitnessApp".tr),
                                          content: Text(
                                            "invalidEmailOrPassword".tr,
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text("ok".tr),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                            } catch (e) {
                              // If there was an error during the registration process
                              controllers.isAsyncCallProcess.value = false;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("fitnessApp".tr),
                                    content: Text(
                                        "${"anErrorOccurred".tr}: ${e.toString()}"),
                                    actions: [
                                      TextButton(
                                        child: Text("ok".tr),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Text(
                          "signIn".tr,
                          style: const TextStyle(
                            color: AppColors.cWhiteClr,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String? validate(String? value, String inputName) {
    if (value!.isEmpty) {
      return "$inputName is required";
    }
    return null;
  }

  String? validatePassword(String? value, String? password) {
    if (password == null || value!.length < 6) {
      return 'Password must be 6 charachter and above';
    } else {
      return null;
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
