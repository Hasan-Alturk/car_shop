import 'package:bot_toast/bot_toast.dart';
import 'package:car_shop/app/core/constants/const_lists.dart';
import 'package:car_shop/app/core/enums.dart';
import 'package:car_shop/app/core/models/car_model.dart';
import 'package:car_shop/app/core/models/filter_model.dart';
import 'package:car_shop/app/core/repo/home_repo.dart';
import 'package:car_shop/app/core/services/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarsController extends GetxController {
  HomeRepo homeRepo;
  ScrollController scrollController = ScrollController();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  int categoryIndex = 0;
  int skip = 0;
  List<String> selectedCategories = [];
  RangeValues priceRangeValues = const RangeValues(100000, 1000000);
  WidgetState widgetState = WidgetState.loading;
  List<Car> cars = [];
  CarsController({required this.homeRepo});
  Future<void> getCars([bool isLoadingMore = false]) async {
    try {
      if (isLoadingMore) {
        widgetState = WidgetState.loadingMore;
      } else {
        widgetState = WidgetState.loading;
        cars.clear();
        skip = 0;
      }
      update(["carsGetBuilder"]);
      List<Car> tempCars = await homeRepo.getCars(
          skip: skip, category: categories[categoryIndex]);
      cars.addAll(tempCars);
      if (tempCars.isEmpty) {
        widgetState = WidgetState.noMoreData;
        BotToast.showText(text: "No More Data");
      } else {
        cars.isEmpty
            ? widgetState = WidgetState.empty
            : widgetState = WidgetState.done;
      }
      skip++;
    } on ExceptionHandler catch (e) {
      if (isLoadingMore) {
        widgetState = WidgetState.done;
      } else {
        widgetState = WidgetState.error;
      }

      BotToast.showText(text: e.error);
    }
    update(["carsGetBuilder"]);
  }

  void carsPagination() {
    if (widgetState != WidgetState.loadingMore &&
        widgetState != WidgetState.noMoreData) {
      getCars(true);
    }
  }

  void changeCategoryIndex(int categoryIndex) {
    if (this.categoryIndex != categoryIndex) {
      this.categoryIndex = categoryIndex;
      getCars();
      update(["categoriesGetBuilder"]);
    }
  }

  @override
  void onInit() {
    getCars();
    super.onInit();
  }

  void changePriceSlider(RangeValues value) {
    priceRangeValues = value;
    update(["filterSlider"]);
  }

  void goToFilter() {
    FilterModel filterModel = FilterModel(
      brand: brandController.text,
      categories: selectedCategories,
      endPrice: priceRangeValues.end.toString(),
      model: modelController.text,
      startPrice: priceRangeValues.start.toString(),
      yom: selectedDate == null ? null : selectedDate!.year.toString(),
    );
    Get.back();
    Get.toNamed("/filter", arguments: {"filterData": filterModel});
    resetFilter();
  }

  DateTime? selectedDate;

  Future<void> selectDate(BuildContext context) async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000, 0),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    update(["YomBuilder"]);
  }

  void selectFilterCategory(int index) {
    bool isSelected = isCategorySelected(index);
    if (isSelected) {
      selectedCategories.remove(categories[index]);
    } else {
      selectedCategories.add(categories[index]);
    }
    update(["FilterCategory"]);
  }

  bool isCategorySelected(int index) {
    return selectedCategories.contains(categories[index]);
  }

  void resetFilter() {
    brandController = TextEditingController();
    selectedCategories.clear();
    priceRangeValues = const RangeValues(100000, 1000000);
    selectedDate = null;
    modelController = TextEditingController();
  }
}
