import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class FirebaseFailure extends Failure {
  FirebaseFailure(this.message) : super(message);

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}