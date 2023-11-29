import 'dart:developer';

import 'package:car_shop/app/core/models/car_model.dart';
import 'package:car_shop/app/core/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();
  static String appUserKey = "appUser";
  static String userBoxKey = "userBox";

  late final Box<User> userBox;

  User? getUser() {
    User? user = userBox.get(appUserKey);
    return user;
  }

  Future<void> openStorage() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(CarAdapter());
    userBox = await Hive.openBox<User>(userBoxKey);
    log("initHive");
  }

  Future<void> removeUser() async {
    await userBox.delete(appUserKey);
  }

  Future<void> saveUser(User user) async {
    await userBox.put(appUserKey, user);
  }
}
