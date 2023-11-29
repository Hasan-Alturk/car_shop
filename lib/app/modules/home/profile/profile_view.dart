import 'dart:developer';

import 'package:car_shop/app/core/enums.dart';
import 'package:car_shop/app/core/widgets/custom_text_field.dart';
import 'package:car_shop/app/core/widgets/state_button.dart';
import 'package:car_shop/app/modules/home/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
          id: "ProfileView",
          builder: (context) {
            switch (controller.widgetState) {
              case WidgetState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case WidgetState.error:
                return Center(
                  child: ElevatedButton(
                      onPressed: controller.getUserInfo,
                      child: const Text("Try Again")),
                );
              default:
                return Form(
                  key: formKey,
                  child: ListView(padding: const EdgeInsets.all(20), children: [
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
                        hint: "********",
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
                      child: GetBuilder<ProfileController>(
                          id: "UpdateUser",
                          builder: (_) {
                            return StateButton(
                              onPressed: () {
                                isChanged = true;
                                if (formKey.currentState!.validate()) {
                                  controller.updateUser();
                                } else {
                                  log("Error From validate");
                                }
                              },
                              text: "Update User",
                              isLoading:
                                  controller.widgetState == WidgetState.loading,
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controller.logout();
                        },
                        child: const Text("Logout"))
                  ]),
                );
            }
          }),
    );
  }
}
