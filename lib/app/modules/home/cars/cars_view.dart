import 'package:car_shop/app/core/constants/const_lists.dart';
import 'package:car_shop/app/core/enums.dart';
import 'package:car_shop/app/core/widgets/car_card.dart';
import 'package:car_shop/app/core/widgets/custom_text_field.dart';
import 'package:car_shop/app/modules/home/cars/cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarsView extends GetView<CarsController> {
  const CarsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Car Shop"),
          actions: [
            InkWell(
                onTap: () {
                  showBottomSheet(context);
                },
                child: const Icon(Icons.filter_alt))
          ],
        ),
        body: Column(
          children: [
            GetBuilder<CarsController>(
                id: "categoriesGetBuilder",
                builder: (_) {
                  return SizedBox(
                    height: 90,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: controller.categoryIndex == index
                                    ? Colors.blue
                                    : Colors.grey),
                            onPressed: () {
                              controller.changeCategoryIndex(index);
                            },
                            child: Text(categories[index]));
                      },
                    ),
                  );
                }),
            _carsWidget(context)
          ],
        ));
  }

  Widget _carsWidget(BuildContext context) {
    return GetBuilder<CarsController>(
        id: "carsGetBuilder",
        builder: (_) {
          switch (controller.widgetState) {
            case WidgetState.loading:
              return const Center(child: CircularProgressIndicator());
            case WidgetState.error:
              return Center(
                child: ElevatedButton(
                    onPressed: controller.getCars,
                    child: const Text("Try Again")),
              );
            case WidgetState.empty:
              return const Center(
                child: Text("No cars"),
              );
            default:
              return SizedBox(
                height: MediaQuery.of(context).size.height - 233,
                child: NotificationListener(
                  onNotification: (t) {
                    if (t is ScrollEndNotification) {
                      if (controller.scrollController.position.pixels ==
                          controller
                              .scrollController.position.maxScrollExtent) {
                        controller.carsPagination();
                      }
                    }
                    return true;
                  },
                  child: ListView.separated(
                    controller: controller.scrollController,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    itemCount: controller.cars.length + 1,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      if (controller.cars.length == index) {
                        return controller.widgetState == WidgetState.loadingMore
                            ? const Center(
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator()),
                              )
                            : const SizedBox();
                      } else {
                        return CarCard(car: controller.cars[index]);
                      }
                    },
                  ),
                ),
              );
          }
        });
  }

  void showBottomSheet(BuildContext context) {
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Colors.white),
          height: MediaQuery.of(context).size.height * 0.7,
          width: double.infinity,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextField(
                        controller: controller.brandController,
                        label: "Brand",
                        hint: "Brand",
                        onChanged: (text) {}),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: InkWell(
                      onTap: () {
                        controller.selectDate(context);
                      },
                      child: GetBuilder<CarsController>(
                          id: "YomBuilder",
                          builder: (_) {
                            return CustomTextField(
                                disable: true,
                                controller: TextEditingController(
                                  text: controller.selectedDate == null
                                      ? null
                                      : controller.selectedDate!.year
                                          .toString(),
                                ),
                                label: "Yom",
                                hint: "Yom",
                                onChanged: (text) {});
                          }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: controller.modelController,
                  label: "Model",
                  hint: "Car Model",
                  onChanged: (text) {}),
              const SizedBox(height: 10),
              const Text("Price"),
              GetBuilder<CarsController>(
                  id: "filterSlider",
                  builder: (_) {
                    return RangeSlider(
                      values: controller.priceRangeValues,
                      onChanged: controller.changePriceSlider,
                      divisions: 10,
                      labels: RangeLabels(
                        controller.priceRangeValues.start.toString(),
                        controller.priceRangeValues.end.toString(),
                      ),
                      min: 100000,
                      max: 1000000,
                    );
                  }),
              const Text("Category"),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: GetBuilder<CarsController>(
                    id: "FilterCategory",
                    builder: (_) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (_, index) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: controller.isCategorySelected(index)
                                    ? Colors.blue
                                    : Colors.grey),
                            onPressed: () {
                              controller.selectFilterCategory(index);
                            },
                            child: Text(categories[index])),
                        itemCount: categories.length,
                      );
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.goToFilter();
                  },
                  child: const Text("Filter"))
            ],
          ),
        ),
        isScrollControlled: true,
        enableDrag: true);
  }
}
