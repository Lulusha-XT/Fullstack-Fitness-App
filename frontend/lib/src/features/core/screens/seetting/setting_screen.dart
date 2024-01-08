import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/localization/languge_services.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
      appBar: AppBar(
        title: Text(
          "setting".tr,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(
              'changeLanguage'.tr,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            trailing: DropdownButton<Locale>(
              value: selectedLocale,
              onChanged: (Locale? newValue) {
                setState(() {
                  selectedLocale = newValue!;
                  _updateLanguage(newValue); // Call the _updateLanguage method
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
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () {
              // Perform the language change action here, e.g., save to preferences
              // You can use a package like shared_preferences for this purpose.
              // Example: SharedPreferences.getInstance().then((prefs) => prefs.setString('language', selectedLocale.languageCode));

              // After changing the language, you can navigate to another screen using GetX.
              Get.offNamed('/home'); // Replace with your screen's route name.
            },
            // Customize the button's appearance to match your app's theme
            child: Text(
              'saveChanges'.tr,
              style: const TextStyle(
                fontSize: 18.0,
                color: AppColors.cWhiteClr,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
