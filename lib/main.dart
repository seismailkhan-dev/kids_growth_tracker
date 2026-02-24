// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/services/sharedpref_service.dart';
import 'core/theme/app_theme.dart';
import 'controllers/app_controller.dart';
import 'firebase_options.dart';
import 'views/splash/splash_screen.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  await SharedPrefService.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AppController(),permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return Obx(() => GetMaterialApp(
      title: 'GrowthBuddy',
      debugShowCheckedModeBanner: false,
      themeMode: controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const SplashScreen(),
    ));
  }
}
