import 'package:car_shop/app/core/enums.dart';
import 'package:car_shop/app/core/widgets/cart_car.dart';
import 'package:car_shop/app/modules/home/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "My Cart",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getUserCars();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: GetBuilder<CartController>(
                id: "CartView",
                builder: (controller) {
                  switch (controller.widgetState) {
                    case WidgetState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case WidgetState.error:
                      return Center(
                        child: ElevatedButton(
                            onPressed: controller.getUserCars,
                            child: const Text("Try Again")),
                      );
                    case WidgetState.empty:
                      return const Center(
                        child: Text("No cars yet"),
                      );
                    default:
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 15);
                        },
                        itemCount: controller.userCars.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CartCar(
                            car: controller.userCars[index],
                            onDelete: controller.removeFromCart,
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ),
        ));
  }
}
