import 'package:bot_toast/bot_toast.dart';
import 'package:car_shop/app/core/enums.dart';
import 'package:car_shop/app/core/models/user_model.dart';
import 'package:car_shop/app/core/repo/home_repo.dart';
import 'package:car_shop/app/core/services/error_handler.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final HomeRepo homeRepo;
  final StorageService storageService;
  late User user;
  WidgetState widgetState = WidgetState.loading;
  ProfileController({required this.homeRepo, required this.storageService});
  late TextEditingController fullnameController;
  late TextEditingController usernameController;
  TextEditingController passwordController = TextEditingController();
  late TextEditingController phoneController;
  late TextEditingController cityController;
  Future<void> getUserInfo() async {
    try {
      widgetState = WidgetState.loading;
      update(["ProfileView"]);
      user = storageService.getUser()!;
      user = await homeRepo.getUserInfo(userId: user.id);
      widgetState = WidgetState.done;
      phoneController = TextEditingController(text: user.phone);
      cityController = TextEditingController(text: user.city);
      usernameController = TextEditingController(text: user.username);
      fullnameController = TextEditingController(text: user.fullName);
    } on ExceptionHandler catch (e) {
      widgetState = WidgetState.error;
      BotToast.showText(text: e.error);
    }
    update(["ProfileView"]);
  }

  Future<void> updateUser() async {
    try {
      widgetState = WidgetState.loading;
      update(["UpdateUser"]);
      await homeRepo.updateUser(
        userId: user.id,
        username: usernameController.text,
        password: passwordController.text,
        fullName: fullnameController.text,
        city: cityController.text,
        phone: phoneController.text,
      );

      await storageService.saveUser(user.copyWith(
        username: usernameController.text,
        fullName: fullnameController.text,
        city: cityController.text,
        phone: phoneController.text,
      ));
      BotToast.showText(text: "User has been updated");
    } on ExceptionHandler catch (e) {
      print(e);
    }
    widgetState = WidgetState.done;
    update(["UpdateUser"]);
  }

  Future<void> logout() async {
    await storageService.removeUser();
    Get.offAllNamed("/wrapper");
  }

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }
}
