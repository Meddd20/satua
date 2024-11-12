import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'package:get/get.dart';
import 'package:satua/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: 'AIzaSyCl5A197OLh-KHStv4kWlVrv3Evp88gBj0', enableDebugging: true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uid = prefs.getString('userToken') ?? '';
  runApp(MyApp(initialUid: uid));
}

class MyApp extends StatelessWidget {
  final String? initialUid;

  const MyApp({super.key, this.initialUid});

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   title: "Application",
    //   initialRoute: initialUid != '' ? Routes.HOME : AppPages.INITIAL,
    //   getPages: AppPages.routes,
    //   debugShowCheckedModeBanner: false,
    // );
    return DevicePreview(
      isToolbarVisible: true,
      builder: (context) => GetMaterialApp(
        title: "Application",
        initialRoute: initialUid != '' ? Routes.HOME : AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        color: const Color(0xFFFCFCFF),
      ),
    );
  }
}
