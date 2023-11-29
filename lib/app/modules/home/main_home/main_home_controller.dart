import 'package:car_shop/app/modules/home/cart/cart_binding.dart';
import 'package:car_shop/app/modules/home/profile/profile_binding.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  PageController pageController = PageController();
  int pageIndex = 0;
  void changePage(int pageIndex) {
    this.pageIndex = pageIndex;
    pageController.jumpToPage(
      pageIndex,
      // duration: const Duration(milliseconds: 500),
      // curve: Curves.ease,
    );
    update(["MainHomeViewGetBuilder"]);
    if (pageIndex == 1) {
      CartBinding().dependencies();
    } else if (pageIndex == 2) {
      ProfileBinding().dependencies();
    }
  }
}
