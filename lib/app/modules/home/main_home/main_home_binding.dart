import 'package:car_shop/app/core/repo/home_repo.dart';
import 'package:car_shop/app/modules/home/cars/cars_binding.dart';
import 'package:car_shop/app/modules/home/main_home/main_home_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainHomeController());
    Get.put(HomeRepo(dio: Get.find<Dio>()));
    CarsBinding().dependencies();
  }
}
