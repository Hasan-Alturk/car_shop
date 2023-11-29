import 'package:car_shop/app/core/repo/home_repo.dart';
import 'package:car_shop/app/modules/home/cars/cars_controller.dart';
import 'package:get/get.dart';

class CarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CarsController(homeRepo: Get.find<HomeRepo>()));
  }
}
