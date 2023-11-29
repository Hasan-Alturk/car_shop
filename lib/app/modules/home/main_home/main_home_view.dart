import 'package:car_shop/app/modules/home/cars/cars_view.dart';
import 'package:car_shop/app/modules/home/cart/cart_view.dart';
import 'package:car_shop/app/modules/home/main_home/main_home_controller.dart';
import 'package:car_shop/app/modules/home/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeView extends GetView<MainHomeController> {
  const MainHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          const CarsView(),
          const CartView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: GetBuilder<MainHomeController>(
        id: "MainHomeViewGetBuilder",
        builder: (_) {
          return BottomNavigationBar(
            onTap: controller.changePage,
            currentIndex: controller.pageIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.shop), label: "cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ],
          );
        },
      ),
    );
  }
}
