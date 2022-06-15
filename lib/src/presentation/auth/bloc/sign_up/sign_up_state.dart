import 'package:equatable/equatable.dart';

enum SignUpStateValue {
  IN_PROGRESS,
  DONE
}

class SignUpState extends Equatable {
  const SignUpState(this.result, this.state, {
    this.registrationComplete = false
  });

  final Map<String, dynamic> result;
  final SignUpStateValue state;
  final bool registrationComplete;

  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpState {
  const SignUpInitialState(super.result, super.state);
}

class SignUpFailState extends SignUpState {
  const SignUpFailState(super.result, super.state, this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class SignUpSuccessState extends SignUpState {
  const SignUpSuccessState(super.result, super.state);
}

class SignUpProgressState extends SignUpState {
  const SignUpProgressState(super.result, super.state);
}