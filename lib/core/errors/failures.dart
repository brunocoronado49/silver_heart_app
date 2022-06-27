import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

// Failure for firebase
class FirebaseFailure extends Failure {
  const FirebaseFailure(this.message) : super(message);

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

// Failure for image picker
class ImagePickerFailure extends Failure {
  final String message;

  const ImagePickerFailure(this.message) : super(message);

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}
