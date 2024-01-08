import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/circularProgressBar/circular_progress_widget.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/features/authentication/controllers/signup_controllers.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(SignUpControllers());
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controllers.fullname,
            decoration: InputDecoration(
              label: Text("fullName".tr),
              prefixIcon: const Icon(Icons.person_outline_rounded),
            ),
            validator: (value) => validate(value, "fullName".tr),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.email,
            decoration: InputDecoration(
              label: Text("email".tr),
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            validator: (value) => validateEmail(value),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.phoneNo,
            decoration: InputDecoration(
              label: Text("phoneNumber".tr),
              prefixIcon: const Icon(Icons.phone_outlined),
            ),
            validator: (value) => validatePhoneNumber(value),
          ),
          const SizedBox(height: cFormHeigth - 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              fillColor: Colors.black,
              labelText: "gender".tr,
              prefixIcon: const Icon(Icons.person_2_outlined),
            ),
            validator: (value) => validate(value, "gender".tr),
            onChanged: (value) {
              if (value != null) {
                controllers.gender = value;
              }
            },
            onSaved: (value) {
              if (value != null) {
                controllers.gender = value;
              }
            },
            items: ['Male', 'Female'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
                  color: AppColors.cOrange,
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
          const SizedBox(height: 20),
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
                          // Show circular progress indicator while creating user
                          controllers.isAsyncCallProcess.value = true;
                          final UserModel user = UserModel(
                            email: controllers.email.text.trim(),
                            password: controllers.password.text.trim(),
                            fullName: controllers.fullname.text.trim(),
                            phoneNo: controllers.phoneNo.text.trim(),
                            gender: controllers.gender,
                          );
                          try {
                            await SignUpControllers.instance.createUser(user)
                                ?
                                // If the registration was successful
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("fitnessApp".tr),
                                        content: Text(
                                            "registrationCompletedSuccessfully"
                                                .tr),
                                        actions: [
                                          TextButton(
                                            child: Text("ok".tr),
                                            onPressed: () {
                                              Get.to(
                                                () => WelcomeScreen(user: user),
                                              );
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
                                            "thisEmailIsAlreadyRegistered".tr),
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
                                    "${"anErrorOccurred"}.tr: ${e.toString()}",
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
                          }
                          //   Get.to(() => const OTPScrenn());
                        }
                      },
                      child: Text(
                        "signUp".tr,
                        style: const TextStyle(
                          color: AppColors.cWhiteClr,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String? validate(String? value, String inputName) {
    if (value == null || value.isEmpty) {
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

  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
      // You can adjust the regular expression pattern to match your desired phone number format
      return 'Please enter a valid phone number';
    }
    return null;
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
