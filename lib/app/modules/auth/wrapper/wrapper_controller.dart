import 'package:car_shop/app/core/models/user_model.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:get/get.dart';

class WrapperController extends GetxController {
  WrapperController(this.storageService);
  final StorageService storageService;
  void getUserLastState() async {
    User? user = await Future.value(storageService.getUser());
    if (user != null) {
      Get.offAllNamed("/mainHome");
    } else {
      Get.offAllNamed("/login");
    }
  }

  @override
  void onInit() {
    getUserLastState();
    super.onInit();
  }
}
