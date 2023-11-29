import 'package:car_shop/app/modules/auth/wrapper/wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WrapperView extends GetView<WrapperController> {
  const WrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
