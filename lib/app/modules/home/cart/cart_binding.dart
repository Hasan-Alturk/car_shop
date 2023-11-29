import 'package:car_shop/app/core/repo/home_repo.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:car_shop/app/modules/home/cart/cart_controller.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController(
      homeRepo: Get.find<HomeRepo>(),
      storageService: Get.find<StorageService>(),
    ));
  }
}
