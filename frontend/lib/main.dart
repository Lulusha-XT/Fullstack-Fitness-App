import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/features/authentication/screens/signin_screen/signin_screen.dart';
import 'package:frontend/src/features/authentication/screens/signup_screen/signup_screen.dart';
import 'package:frontend/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/bmi_calculatore_screen.dart';
import 'package:frontend/src/features/core/screens/seetting/setting_screen.dart';
import 'package:frontend/src/features/core/screens/dashboard/dashboard_screen.dart';
import 'package:frontend/src/features/core/screens/profile/profile_screen.dart';
import 'package:frontend/src/localization/languge_services.dart';
import 'package:frontend/src/localization/local_string.dart';
import 'package:frontend/src/utils/shared_service.dart';
import 'package:frontend/src/utils/themes/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/features/core/models/exercise_model.dart';
import 'src/features/core/models/exercise_category_model.dart';

Widget _defoultHome = SplashScreen();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(ExerciseCategoryAdapter());
  Hive.registerAdapter(WorkoutAdapter());

  await Hive.openBox<Exercise>('selected_exercises');
  await Hive.openBox<ExerciseCategory>('exercise_categories');
  await Hive.openBox<Workout>('workouts');
  await GetStorage.init();

  bool result = await SharedService.isLoggedIn();
  if (result) {
    _defoultHome = const DashBoardScreen();
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => GetMaterialApp(
        translations: LocalString(),
        locale: LangugeServices().local,
        debugShowCheckedModeBanner: false,
        theme: CAppTheme.ligthTheme,
        darkTheme: CAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        title: 'Fitness App',
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: <String, WidgetBuilder>{
          '/': (context) => _defoultHome,
          '/home': (context) => const DashBoardScreen(),
          '/registore': (context) => const SignUpScreen(),
          '/login': (context) => const SigninScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/bmicalculatore': (context) => const BmiCalculatoreScreen(),
          '/language_selection': (context) => const SettingScreen(),
        },
      ),
    );
  }
}
