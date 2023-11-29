import 'package:bot_toast/bot_toast.dart';
import 'package:car_shop/app/core/enums.dart';
import 'package:car_shop/app/core/models/car_model.dart';
import 'package:car_shop/app/core/models/user_model.dart';
import 'package:car_shop/app/core/repo/home_repo.dart';
import 'package:car_shop/app/core/services/error_handler.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final HomeRepo homeRepo;
  final StorageService storageService;
  List<Car> userCars = [];
  CartController({required this.homeRepo, required this.storageService});
  WidgetState widgetState = WidgetState.loading;
  Future<void> getUserCars() async {
    try {
      widgetState = WidgetState.loading;
      update(["CartView"]);
      User user = storageService.getUser()!;
      userCars = await homeRepo.getUserCars(userId: user.id);
      widgetState = userCars.isEmpty ? WidgetState.empty : WidgetState.done;
    } on ExceptionHandler catch (e) {
      widgetState = WidgetState.error;
      BotToast.showText(text: e.error);
    }
    update(["CartView"]);
  }

  @override
  void onInit() {
    getUserCars();
    super.onInit();
  }

  Future<void> removeFromCart(Car removedCar) async {
    try {
      BotToast.showLoading();
      User user = storageService.getUser()!;
      List<String> cars = [];
      for (Car car in user.cars) {
        if (car.id != removedCar.id) {
          cars.add(car.id);
        }
      }
      await homeRepo.patchUserCars(userId: user.id, cars: cars);
      user.cars.removeWhere(
        (car) => car.id == removedCar.id,
      );
      userCars.removeWhere(
        (car) => car.id == removedCar.id,
      );
      widgetState = userCars.isEmpty ? WidgetState.empty : WidgetState.done;
      await storageService.saveUser(user);
    } on ExceptionHandler catch (e) {
      BotToast.showText(text: e.error);
    }
    update(["CartView"]);
    BotToast.closeAllLoading();
  }
}
