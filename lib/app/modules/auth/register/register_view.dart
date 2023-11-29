import 'dart:developer';

import 'package:car_shop/app/core/widgets/custom_text_field.dart';
import 'package:car_shop/app/core/widgets/state_button.dart';
import 'package:car_shop/app/core/widgets/welcome_widget.dart';
import 'package:car_shop/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.zero, children: [
        const WelcomeWidget(),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "SignUp",
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                CustomTextField(
                    controller: controller.fullnameController,
                    hint: "Enter Your Fullname",
                    label: "Fullname",
                    onChanged: (_) {
                      if (isChanged) {
                        formKey.currentState!.validate();
                      }
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Fullname is required";
                      } else if (text.length > 20) {
                        return "Fullname must be less than 20 char";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: controller.phoneController,
                    hint: "Enter Your Phone",
                    label: "Phone",
                    onChanged: (_) {
                      if (isChanged) {
                        formKey.currentState!.validate();
                      }
                    },
                    textInputType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Phone is required";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: controller.cityController,
                    hint: "Enter Your City",
                    label: "City",
                    onChanged: (_) {
                      if (isChanged) {
                        formKey.currentState!.validate();
                      }
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "City is required";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: GetBuilder<RegisterController>(builder: (_) {
                    return StateButton(
                      onPressed: () {
                        isChanged = true;
                        if (formKey.currentState!.validate()) {
                          controller.register();
                        } else {
                          log("Error From validate");
                        }
                      },
                      text: "SignUp",
                      isLoading: controller.isLoading,
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: controller.goToLogin,
                        child: const Text(
                          "login",
                        )),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
