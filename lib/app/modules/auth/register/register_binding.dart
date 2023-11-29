import 'package:car_shop/app/core/repo/auth_repo.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:car_shop/app/modules/auth/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController(
      authRepo: Get.find<AuthRepo>(),
      storageService: Get.find<StorageService>(),
    ));
  }
}
