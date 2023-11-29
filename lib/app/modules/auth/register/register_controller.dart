import 'package:car_shop/app/core/models/user_model.dart';
import 'package:car_shop/app/core/repo/auth_repo.dart';
import 'package:car_shop/app/core/services/error_handler.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final AuthRepo authRepo;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  StorageService storageService;
  bool isLoading = false;
  RegisterController({
    required this.authRepo,
    required this.storageService,
  });
  Future<void> register() async {
    try {
      isLoading = true;
      update();
      User user = await authRepo.register(
        username: usernameController.text,
        password: passwordController.text,
        fullname: fullnameController.text,
        city: cityController.text,
        phone: phoneController.text,
      );
      isLoading = false;
      update();
      await storageService.saveUser(user);
      Get.offAllNamed("/mainHome");
    } on ExceptionHandler catch (e) {
      print(e);
      isLoading = false;
      update();
    }

    ///storage.saveUser(user);
    // Get.to(Home());
  }

  void goToLogin() {
    Get.offNamed("/login");
  }
}
