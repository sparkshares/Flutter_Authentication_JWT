import 'package:flutter/material.dart';
import 'package:sarangi/screens/auth/auth_screen.dart';
import 'package:sarangi/screens/pages/home.dart';
import 'package:get/get.dart';
import 'package:sarangi/screens/screen.dart';
import 'package:sarangi/screens/splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sarangi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
