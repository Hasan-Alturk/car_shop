import 'package:bot_toast/bot_toast.dart';
import 'package:car_shop/app/core/constants/pages.dart';
import 'package:car_shop/app/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await StorageService.instance.openStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      initialRoute: "/wrapper",
      getPages: appPages,
    );
  }
}
