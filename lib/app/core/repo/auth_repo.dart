import 'dart:developer';

import 'package:car_shop/app/core/models/user_model.dart';
import 'package:car_shop/app/core/services/error_handler.dart';
import 'package:dio/dio.dart';

String baseUrl = "https://cars-mysql-backend.herokuapp.com";

class AuthRepo {
  AuthRepo(this.dio);
  final Dio dio;
  Future<User> login(
      {required String username, required String password}) async {
    try {
      var response = await dio.post("$baseUrl/user/login", data: {
        "username": username,
        "password": password,
      });
      User user = User.fromMap(response.data);
      return user;
    } on DioError catch (e) {
      log(e.response!.statusCode.toString());
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw ExceptionHandler("User not found");
        } else if (e.response!.statusCode == 409) {
          throw ExceptionHandler("Wrong password");
        }
      }
    }
    throw ExceptionHandler("Unknown error");
  }

  Future<User> register({
    required String username,
    required String password,
    required String fullname,
    required String city,
    required String phone,
  }) async {
    try {
      Response response = await dio.post("$baseUrl/user/register", data: {
        "full_name": fullname,
        "username": username,
        "password": password,
        "city": city,
        "phone": phone,
      });
      log(response.data.toString());
      return User.fromMap(response.data);
    } on DioError catch (e) {
      log(e.response!.statusCode.toString());
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ExceptionHandler("User aleady exist");
        }
      }
    }
    throw ExceptionHandler("Unknown error");
  }
}
