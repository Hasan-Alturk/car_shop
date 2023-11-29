import 'package:car_shop/app/modules/auth/login/login_binding.dart';
import 'package:car_shop/app/modules/auth/login/login_view.dart';
import 'package:car_shop/app/modules/auth/register/register_binding.dart';
import 'package:car_shop/app/modules/auth/register/register_view.dart';
import 'package:car_shop/app/modules/auth/wrapper/wrapper_binding.dart';
import 'package:car_shop/app/modules/auth/wrapper/wrapper_view.dart';
import 'package:car_shop/app/modules/home/car_details/car_details_binding.dart';
import 'package:car_shop/app/modules/home/car_details/car_details_view.dart';
import 'package:car_shop/app/modules/home/cars/cars_binding.dart';
import 'package:car_shop/app/modules/home/cars/cars_view.dart';
import 'package:car_shop/app/modules/home/cart/cart_binding.dart';
import 'package:car_shop/app/modules/home/cart/cart_view.dart';
import 'package:car_shop/app/modules/home/filter/filter_binding.dart';
import 'package:car_shop/app/modules/home/filter/filter_view.dart';
import 'package:car_shop/app/modules/home/main_home/main_home_binding.dart';
import 'package:car_shop/app/modules/home/main_home/main_home_view.dart';
import 'package:car_shop/app/modules/home/profile/profile_binding.dart';
import 'package:car_shop/app/modules/home/profile/profile_view.dart';
import 'package:get/get.dart';

List<GetPage> appPages = [
  GetPage(
    name: "/wrapper",
    page: () => const WrapperView(),
    binding: WrapperBinding(),
  ),
  GetPage(
    name: "/login",
    page: () => LoginView(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: "/register",
    page: () => RegisterView(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: "/mainHome",
    page: () => const MainHomeView(),
    binding: MainHomeBinding(),
  ),
  GetPage(
    name: "/cars",
    page: () => const CarsView(),
    binding: CarsBinding(),
  ),
  GetPage(
    name: "/cart",
    page: () => const CartView(),
    binding: CartBinding(),
  ),
  GetPage(
    name: "/profile",
    page: () => ProfileView(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: "/carDetails",
    page: () => const CarDetailsView(),
    binding: CarDetailsBinding(),
  ),
  GetPage(
    name: "/filter",
    page: () => const FilterView(),
    binding: FilterBinding(),
  ),
];
