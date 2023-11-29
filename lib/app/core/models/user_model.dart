import 'package:car_shop/app/core/models/car_model.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.city,
    required this.phone,
    required this.cars,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String fullName;
  @HiveField(3)
  final String city;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final List<Car> cars;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["full_name"],
        city: json["city"],
        phone: json["phone"],
        cars: json["cars"] == null ? [] : Car.carList(json["cars"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "full_name": fullName,
        "city": city,
        "phone": phone,
        "cars": List<dynamic>.from(cars.map((x) => x)),
      };
  @override
  String toString() {
    String text = '''
        "id": $id,
        "username": $username,
        "full_name": $fullName,
        "city": $city,
        "phone": $phone,
        "cars": $cars,
    ''';
    return text;
  }

  User copyWith({
    String? username,
    String? fullName,
    String? city,
    String? phone,
  }) {
    return User(
      id: id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      cars: cars,
    );
  }
}
