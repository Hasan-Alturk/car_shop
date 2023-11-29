import 'package:car_shop/app/core/repo/auth_repo.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:car_shop/app/modules/auth/login/login_contreoller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepo(Get.find<Dio>()), permanent: true);
    Get.put(LoginController(
      authRepo: Get.find<AuthRepo>(),
      storageService: Get.find<StorageService>(),
    ));
  }
}
