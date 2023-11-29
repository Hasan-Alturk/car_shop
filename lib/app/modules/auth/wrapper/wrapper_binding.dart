import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:car_shop/app/modules/auth/wrapper/wrapper_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class WrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
        Dio(BaseOptions(
            sendTimeout: 10000, receiveTimeout: 10000, connectTimeout: 10000)),
        permanent: true);

    Get.put(StorageService.instance, permanent: true);
    Get.put(WrapperController(
      Get.find<StorageService>(),
    ));
  }
}
