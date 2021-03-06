import 'package:equatable/equatable.dart';

import 'package:silver_heart/models/models.dart';

class MyUser extends Equatable {
  const MyUser(
    this.id,
    this.name,
    this.description,
    this.address,
    this.phone,
    this.email,
    this.web,
    //this.posts,
    {this.image}
  );

  final String id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final String email;
  final String web;
  final String? image;
  //final List<Post?> posts;

  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?> {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'email': email,
      'web': web,
      'image': newImage ?? image,
      //'posts': newPost ?? posts
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
    : id = data['id'] as String,
      name = data['name'] as String,
      description = data['description'] as String,
      address = data['address'] as String,
      phone = data['phone'] as String,
      email = data['email'] as String,
      web = data['web'] as String,
      image = data['image'] as String?;
      //posts = data["posts"] as List<Post?>;
}
