import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_shop/app/core/models/car_model.dart';
import 'package:car_shop/app/core/models/user_model.dart';
import 'package:car_shop/app/core/repo/home_repo.dart';
import 'package:car_shop/app/core/services/error_handler.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetailsController extends GetxController {
  CarDetailsController({required this.homeRepo, required this.storageService});
  PageController pageController = PageController();
  final HomeRepo homeRepo;
  final StorageService storageService;
  late Car car;
  CarButtonState carButtonState = CarButtonState.add;
  void isAdded() {
    User user = storageService.getUser()!;
    for (Car car in user.cars) {
      if (car.id == this.car.id) {
        carButtonState = CarButtonState.remove;
      }
    }
  }

  @override
  void onInit() {
    car = Get.arguments["car"] as Car;
    isAdded();
    super.onInit();
  }

  Future<void> addToCart() async {
    try {
      carButtonState = CarButtonState.loading;
      update(["CarButtonState"]);
      User user = storageService.getUser()!;

      List<String> cars = [car.id];
      for (Car car in user.cars) {
        cars.add(car.id);
      }

      await homeRepo.patchUserCars(userId: user.id, cars: cars);
      log(user.cars.length.toString());
      user.cars.add(car);
      log(user.cars.length.toString());
      await storageService.saveUser(user);
      carButtonState = CarButtonState.remove;
    } on ExceptionHandler catch (e) {
      BotToast.showText(text: e.error);
      carButtonState = CarButtonState.add;
    }
    update(["CarButtonState"]);
  }

  Future<void> removeFromCart() async {
    try {
      carButtonState = CarButtonState.loading;
      update(["CarButtonState"]);
      User user = storageService.getUser()!;

      List<String> cars = [];
      for (Car car in user.cars) {
        if (car.id != this.car.id) {
          cars.add(car.id);
        }
      }

      await homeRepo.patchUserCars(userId: user.id, cars: cars);
      log(user.cars.length.toString());
      user.cars.removeWhere(
        (car) => car.id == this.car.id,
      );
      log(user.cars.length.toString());
      await storageService.saveUser(user);
      carButtonState = CarButtonState.add;
    } on ExceptionHandler catch (e) {
      BotToast.showText(text: e.error);
      carButtonState = CarButtonState.add;
    }
    update(["CarButtonState"]);
  }
}

enum CarButtonState { add, remove, loading }
