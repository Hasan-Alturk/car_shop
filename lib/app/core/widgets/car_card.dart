import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_shop/app/core/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarCard extends StatelessWidget {
  const CarCard({
    required this.car,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);
  final Car car;
  final double? width;
  final double? height;
  final double _height = 220;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/carDetails", arguments: {"car": car});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: width ?? MediaQuery.of(context).size.width - 40,
          height: height ?? _height,
          child: Stack(
            children: [
              SizedBox(
                width: width ?? MediaQuery.of(context).size.width - 40,
                height: height ?? _height,
                child: ClipRRect(
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
              Container(
                width: width ?? MediaQuery.of(context).size.width - 40,
                height: height ?? _height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Colors.black87,
                      Colors.transparent,
                    ])),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                width: width ?? MediaQuery.of(context).size.width - 40,
                height: height ?? _height,
                decoration: const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      car.model,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          car.brand,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${car.price}\$",
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
