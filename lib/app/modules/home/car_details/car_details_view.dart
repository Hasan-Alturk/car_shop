import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_shop/app/modules/home/car_details/car_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarDetailsView extends GetView<CarDetailsController> {
  const CarDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetBuilder<CarDetailsController>(
          id: "CarButtonState",
          builder: (_) {
            switch (controller.carButtonState) {
              case CarButtonState.add:
                return ElevatedButton(
                    onPressed: () {
                      controller.addToCart();
                    },
                    child: const Text("Add To Cart"));
              case CarButtonState.remove:
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent[100]),
                    onPressed: () {
                      controller.removeFromCart();
                    },
                    child: const Text("Remove From Cart"));
              case CarButtonState.loading:
                return const ElevatedButton(
                    onPressed: null, child: CircularProgressIndicator());
            }
          }),
      body: ListView(children: [
        _carImages(),
        const SizedBox(height: 5),
        Center(
          child: SmoothPageIndicator(
            controller: controller.pageController,
            count: controller.car.carImages.length,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ),
        _carInfo(),
      ]),
    );
  }

  Widget _carInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(controller.car.model),
              Text(controller.car.price),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(controller.car.brand),
              Text(controller.car.category),
            ],
          ),
          Row(
            children: [
              const Text("Year of manufacture:  "),
              Text(controller.car.yom),
            ],
          ),
          Row(
            children: [
              const Text("Color:  "),
              Text(controller.car.color),
            ],
          ),
          const Text("Description:"),
          Text(controller.car.description),
        ],
      ),
    );
  }

  Widget _carImages() {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView(
              controller: controller.pageController,
              children: controller.car.carImages
                  .map(
                    (image) => Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    Center(child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter,
                                  colors: [
                                Colors.black87,
                                Colors.transparent
                              ])),
                        )
                      ],
                    ),
                  )
                  .toList()),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back, color: Colors.white)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Car Details",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
