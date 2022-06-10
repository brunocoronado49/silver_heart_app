import './user.dart';

class Product {
  String? type;
  String? name;
  double? price;
  User? user;
  bool favorite;

  Product({
    this.name,
    this.price,
    this.type,
    this.user,
    this.favorite = false,
  });
}