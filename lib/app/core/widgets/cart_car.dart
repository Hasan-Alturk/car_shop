import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_shop/app/core/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartCar extends StatelessWidget {
  const CartCar({required this.car, required this.onDelete, Key? key})
      : super(key: key);
  final Car car;
  final void Function(Car car) onDelete;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/carDetails", arguments: {"car": car});
      },
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
            color: const Color(0xffefefef),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: car.mainImage,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(car.model),
                    const SizedBox(width: 10),
                    Text(car.brand),
                  ],
                ),
                Text("${car.price}\$"),
              ],
            ),
            const Spacer(),
            InkWell(
                onTap: () {
                  onDelete(car);
                },
                child: const Icon(Icons.close)),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
