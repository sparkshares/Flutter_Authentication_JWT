import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sarangi/screens/pages/home.dart';
import 'package:sarangi/screens/screen.dart';
import 'package:sarangi/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginEmail);

      Map body = {
        "email": emailController.text.trim(),
        "password": passwordController.text
      };

      http.Response response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("entered into if");

        final json = jsonDecode(response.body);
        if (json.containsKey('token')) {
          var token = json['token']['access'];
          print(" token is = " + token);

          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          emailController.clear();
          passwordController.clear();
          Get.off(ScreenPage());
        } else {
          throw jsonDecode(response.body)['msg'] ?? "Something went wrong";
        }
      } else {
        throw jsonDecode(response.body)['msg'] ?? "Something went wrong";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text("Error"),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
