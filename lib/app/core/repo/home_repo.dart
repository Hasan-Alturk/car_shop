import 'dart:developer';

import 'package:car_shop/app/core/models/car_model.dart';
import 'package:car_shop/app/core/models/filter_model.dart';
import 'package:car_shop/app/core/models/user_model.dart';
import 'package:car_shop/app/core/services/error_handler.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  final Dio dio;
  HomeRepo({required this.dio});
  Future<List<Car>> getCars(
      {required int skip, required String category}) async {
    try {
      Map<String, dynamic>? queryParameters = {
        "skip": skip * 5,
        "take": 5,
      };
      log(queryParameters.toString(), name: "start getCars");
      if (category != "all") {
        queryParameters.addAll({"category": category});
      }
      Response response = await dio.get(
        "https://cars-mysql-backend.herokuapp.com/car/category",
        queryParameters: queryParameters,
      );
      log(response.data.toString());
      return Car.carList(response.data);
    } catch (e) {
      log("error getCars $e");
      throw ExceptionHandler("Can't get cars");
    }
  }

  Future<void> patchUserCars(
      {required String userId, required List<String> cars}) async {
    try {
      log("start patchUserCars");
      await dio.patch(
          "https://cars-mysql-backend.herokuapp.com/user/$userId/cars",
          data: {"cars": cars});
      log("done patchUserCars");
    } catch (e) {
      throw ExceptionHandler("Can't add car to user");
    }
  }

  Future<List<Car>> getUserCars({required String userId}) async {
    try {
      log("start getUserCars");
      Response response = await dio.get(
        "https://cars-mysql-backend.herokuapp.com/user/$userId",
      );
      log("done getUserCars");
      return Car.carList(response.data["cars"]);
    } catch (e) {
      throw ExceptionHandler("Can't Get User Cars");
    }
  }

  Future<User> getUserInfo({required String userId}) async {
    try {
      log("start getUser");
      Response response = await dio.get(
        "https://cars-mysql-backend.herokuapp.com/user/$userId",
      );
      log("done getUser");
      return User.fromMap(response.data);
    } catch (e) {
      throw ExceptionHandler("Can't Get User");
    }
  }

  Future<void> updateUser({
    required String userId,
    String? fullName,
    String? username,
    String? password,
    String? city,
    String? phone,
  }) async {
    try {
      log("start updateUser");
      Map data = {
        "full_name": fullName,
        "username": username,
        "password": password,
        "city": city,
        "phone": phone,
      };
      data.removeWhere((key, value) => value == null);
      await dio.patch("https://cars-mysql-backend.herokuapp.com/user/$userId",
          data: data);
      log("done updateUser");
    } catch (e) {
      throw ExceptionHandler("Can't Get User");
    }
  }

  Future<List<Car>> filterCars({
    required int skip,
    required FilterModel filter,
  }) async {
    try {
      Map<String, dynamic>? queryParameters = {
        "skip": skip * 10,
        "take": 10,
        "brand": filter.brand,
        "model": filter.model,
        // "yom": filter.yom,
        // "price": filter.startPrice,
        "startPrice": filter.startPrice,
        "endPrice": filter.endPrice,
        "categories": filter.categories,
      };
      queryParameters.removeWhere((key, value) => value == null || value == "");
      log("start filterCars");
      Response response = await dio.get(
          "https://cars-mysql-backend.herokuapp.com/car/filter",
          queryParameters: queryParameters);
      log("done filterCars ${response.data}");
      return Car.carList(response.data);
    } catch (e) {
      throw ExceptionHandler("Can't filter Cars");
    }
  }
}
