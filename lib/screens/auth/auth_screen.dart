// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarangi/controllers/login_controller.dart';
import 'package:sarangi/controllers/registration_controller.dart';
import 'package:sarangi/screens/auth/widgets/input_fields.dart';
import 'package:sarangi/screens/auth/widgets/submit_button.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegisterController registerationController = Get.put(RegisterController());

  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Obx(
              () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Text(
                        'SARANGI',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MaterialButton(
                              height: 50,
                              shape:
                                  RoundedRectangleBorder(), // Removed borderRadius
                              color:
                                  !isLogin.value ? Colors.blue : Colors.white,
                              onPressed: () {
                                isLogin.value = false;
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: !isLogin.value
                                      ? Colors.white
                                      : Colors
                                          .black, // Set the color to white when isLogin.value is false, otherwise set it to black
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MaterialButton(
                              height: 50,
                              shape:
                                  RoundedRectangleBorder(), // Removed borderRadius
                              color: isLogin.value ? Colors.blue : Colors.white,
                              onPressed: () {
                                isLogin.value = true;
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isLogin.value
                                      ? Colors.white
                                      : Colors
                                          .black, // Set the color to white when isLogin.value is true, otherwise set it to black
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    isLogin.value ? loginWidget() : registerWidget()
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: [
        InputTextFieldWidget(
            registerationController.nameController, 'Full Name', false),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.emailController, 'Email Address', false),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.passwordController, 'Password', true),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(registerationController.passwordController2,
            'Confirm Password', true),
        SizedBox(
          height: 50,
        ),
        SubmitButton(
          onPressed: () => registerationController.registerWithEmail(),
          title: 'Register',
        )
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            loginController.emailController, 'Email Address', false),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            loginController.passwordController, 'Password', true),
        SizedBox(
          height: 50,
        ),
        SubmitButton(
          onPressed: () => loginController.loginWithEmail(),
          title: 'Login',
        )
      ],
    );
  }
}
