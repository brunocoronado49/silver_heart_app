import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post(
    this.price,
    this.type,
    this.name,
    this.description,
    this.seller,
    this.userId,
    {this.picture}
  );

  final String price;
  final String type;
  final String name;
  final String description;
  final String seller;
  final String userId;
  final String? picture;

  @override
  List<Object?> get props => [];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?> {
      'price': price,
      'type': type,
      'name': name,
      'description': description,
      'seller': seller,
      'userId': userId,
      'picture': newImage ?? picture,
    };
  }

  Post.fromFirebaseMap(Map<String, Object?> data)
    : price = data['price'] as String,
      type = data['type'] as String,
      name = data['name'] as String,
      description = data['description'] as String,
      seller = data['seller'] as String,
      userId = data['userId'] as String,
      picture = data['picture'] as String?;
}
