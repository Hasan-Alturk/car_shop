import 'package:hive/hive.dart';

part 'car_model.g.dart';

@HiveType(typeId: 2)
class Car {
  Car({
    required this.brand,
    required this.model,
    required this.yom,
    required this.color,
    required this.price,
    required this.category,
    required this.description,
    required this.mainImage,
    required this.carImages,
    required this.id,
  });
  static List<Car> carList(List data) =>
      data.map((car) => Car.fromMap(car)).toList();
  @HiveField(0)
  final String brand;
  @HiveField(1)
  final String model;
  @HiveField(2)
  final String yom;
  @HiveField(3)
  final String color;
  @HiveField(4)
  final String price;
  @HiveField(5)
  final String category;
  @HiveField(6)
  final String description;
  @HiveField(7)
  final String mainImage;
  @HiveField(8)
  final List<String> carImages;
  @HiveField(9)
  final String id;

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        brand: json["brand"],
        id: json["id"],
        model: json["model"],
        yom: json["yom"],
        color: json["color"],
        price: json["price"],
        category: json["category"],
        description: json["description"],
        carImages: List<String>.from(json["images"].map((e) => e.toString())),
        mainImage: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "brand": brand,
        "model": model,
        "yom": yom,
        "color": color,
        "price": price,
        "category": category,
        "description": description,
        "image": mainImage,
      };
}
