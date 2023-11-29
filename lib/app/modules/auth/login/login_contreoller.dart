import 'package:car_shop/app/core/models/user_model.dart';
import 'package:car_shop/app/core/repo/auth_repo.dart';
import 'package:car_shop/app/core/services/error_handler.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthRepo authRepo;
  final StorageService storageService;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? error;
  LoginController({
    required this.authRepo,
    required this.storageService,
  });
  Future<void> login() async {
    try {
      error = null;
      isLoading = true;
      update(["TextError", "ElevatedButton"]);
      User user = await authRepo.login(
        username: usernameController.text,
        password: passwordController.text,
      );
      print(user.toString());
      await storageService.saveUser(user);

      Get.offAllNamed("/mainHome");
      isLoading = false;
      update(["ElevatedButton"]);
    } on ExceptionHandler catch (e) {
      print("Error: $e");
      isLoading = false;
      error = e.error;
      update(["TextError", "ElevatedButton"]);
    }
  }

  void goToRegister() {
    Get.offNamed("/register");
  }
}
