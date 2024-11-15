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
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  Gemini.init(apiKey: 'AIzaSyCdX2tsC7QJiF2RTpxUYwou52Viv7pERPk', enableDebugging: true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uid = prefs.getString('userToken') ?? '';
  runApp(MyApp(initialUid: uid));
}

class MyApp extends StatelessWidget {
  final String? initialUid;

  const MyApp({super.key, this.initialUid});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Satua",
      initialRoute: initialUid != '' ? Routes.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFCFCFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFCFCFF),
          surfaceTintColor: Color(0xFFFCFCFF),
        ),
      ),
    );
    // return DevicePreview(
    //   isToolbarVisible: true,
    //   builder: (context) => GetMaterialApp(
    //     title: "Application",
    //     initialRoute: initialUid != '' ? Routes.HOME : AppPages.INITIAL,
    //     getPages: AppPages.routes,
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       scaffoldBackgroundColor: const Color(0xFFFCFCFF),
    //       appBarTheme: const AppBarTheme(
    //         backgroundColor: Color(0xFFFCFCFF),
    //         surfaceTintColor: Color(0xFFFCFCFF),
    //       ),
    //     ),
    //   ),
    // );
  }
}
