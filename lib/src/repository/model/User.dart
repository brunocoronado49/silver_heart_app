import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.photo
  }) : assert(email != null), assert(id != null);

  final String id;
  final String? name;
  final String email;
  final String? photo;

  static const empty = User(id: '', name: null, email: '', photo: null);

  @override
  List<Object?> get props => [id, name, email, photo];

}