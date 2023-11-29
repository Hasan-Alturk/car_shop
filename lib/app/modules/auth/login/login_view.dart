import 'dart:developer';

import 'package:car_shop/app/core/widgets/custom_text_field.dart';
import 'package:car_shop/app/core/widgets/state_button.dart';
import 'package:car_shop/app/core/widgets/welcome_widget.dart';
import 'package:car_shop/app/modules/auth/login/login_contreoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const WelcomeWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: const [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: controller.usernameController,
                  hint: "Enter Your Username",
                  label: "Username",
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Username is required";
                    } else if (text.length > 20) {
                      return "Username must be less than 20 char";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (_) {
                    if (isChanged) {
                      formKey.currentState!.validate();
                    }
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: controller.passwordController,
                    hint: "Enter Your Password",
                    label: "Password",
                    obscureText: true,
                    onChanged: (_) {
                      if (isChanged) {
                        formKey.currentState!.validate();
                      }
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Password is required";
                      } else if (text.length < 8) {
                        return "Password must be longer than 8 char";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 30),
                GetBuilder<LoginController>(
                    id: "ElevatedButton",
                    builder: (_) {
                      return SizedBox(
                        width: 150,
                        height: 50,
                        child: StateButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.login();
                            } else {
                              log("Error From validate");
                            }
                          },
                          text: "Login",
                          isLoading: controller.isLoading,
                        ),
                      );
                    }),
                GetBuilder<LoginController>(
                    id: "TextError",
                    builder: (_) {
                      return Text(controller.error ?? "");
                    }),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: controller.goToRegister,
                        child: const Text(
                          "Register",
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
