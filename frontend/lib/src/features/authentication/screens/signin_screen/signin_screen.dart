import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/form/form_header_widget.dart';
import 'package:frontend/src/constants/image_strings.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/features/authentication/screens/signin_screen/widgets/signin_footer_widget.dart';
import 'package:frontend/src/features/authentication/screens/signin_screen/widgets/signin_form_widget.dart';
import 'package:frontend/src/localization/languge_services.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  Locale selectedLocale = LangugeServices().local;
  // Initial language selection
  // Method to update the app's language
  _updateLanguage(Locale local) {
    LangugeServices().switchLanguge(local);
    // Update the app's locale
    Get.updateLocale(LangugeServices().local);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(cDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton<Locale>(
                      value: selectedLocale,
                      onChanged: (Locale? newValue) {
                        setState(() {
                          selectedLocale = newValue!;
                          _updateLanguage(
                              newValue); // Call the _updateLanguage method
                        });
                      },
                      items: const [
                        DropdownMenuItem<Locale>(
                          value: Locale('en', 'US'),
                          child: Text('ENGLISH'),
                        ),
                        DropdownMenuItem<Locale>(
                          value: Locale('et', 'ET'),
                          child: Text('አማርኛ'),
                        ),
                        DropdownMenuItem<Locale>(
                          value: Locale('et', 'TG'),
                          child: Text('ትግሪኛ'),
                        ),
                        DropdownMenuItem<Locale>(
                          value: Locale('et', 'OR'),
                          child: Text('Afaan Oromoo'),
                        ),
                        // Add more locales as needed
                      ],
                    ),
                  ],
                ),
              ),
              FormHeaderWidget(
                image: cAppLogoImage,
                title: "loginTitle".tr,
                subTitle: "loginSubTitle".tr,
              ),
              const SizedBox(height: 10),
              const SignInForm(),
              const SignInFooterWidget()
            ],
          ),
        ),
      ),
    );
  }
}
