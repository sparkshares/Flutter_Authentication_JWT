import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sarangi/screens/pages/home.dart';
import 'package:sarangi/screens/screen.dart';
import 'package:sarangi/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.registerEmail);

      Map body = {
        "name": nameController.text,
        "email": emailController.text.trim(),
        "password": passwordController.text,
        "password2": passwordController2.text
      };

      http.Response response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      print("the body is = " + response.body);
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        if (json.containsKey('token')) {
          var token = json['token']['access'];
          print(token);

          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          passwordController2.clear();

          Get.off(ScreenPage());
        } else {
          throw jsonDecode(response.body)['message'] ?? "Something went wrong";
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Something went wrong";
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
