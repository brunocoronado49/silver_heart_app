import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final int age;
  final String location;

  final String? image;

  MyUser(this.id, this.name, this.lastName, this.age, this.location,{this.image});

  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age,
      'location': location,
      'image': newImage ?? image,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        lastName = data['lastName'] as String,
        age = data['age'] as int,
        location = data['location'] as String,
        image = data['image'] as String?;
}
