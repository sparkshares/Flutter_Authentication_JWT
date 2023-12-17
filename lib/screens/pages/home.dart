import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
            style: TextStyle(
                color: Colors
                    .white)), // Set the AppBar title to 'Home' and the text color to white
        backgroundColor: Colors.blue, // Set the AppBar color to blue
        actions: [
          TextButton(
            onPressed: () async {
              final SharedPreferences? prefs = await _prefs;
              prefs?.clear();
              Get.offAll(AuthScreen());
            },
            child: IconButton(
              icon:
                  Icon(Icons.logout, color: Colors.white), // Add a logout icon
              onPressed: () async {
                final SharedPreferences? prefs = await _prefs;
                prefs?.clear();
                Get.offAll(AuthScreen());
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome home'),
            TextButton(
                onPressed: () async {
                  final SharedPreferences? prefs = await _prefs;
                  print(prefs?.get('token'));
                },
                child: Text('print token'))
          ],
        ),
      ),
    );
  }
}
