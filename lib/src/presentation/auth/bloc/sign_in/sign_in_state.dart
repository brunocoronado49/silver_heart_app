import 'package:equatable/equatable.dart';

enum SignInStateValue {
  IN_PROGRESS,
  DONE
}

class SignInState extends Equatable {
  const SignInState(this.result, this.state);

  final Map<String, dynamic> result;
  final SignInStateValue state;

  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {
  const SignInInitialState(super.result, super.state);
}

class SignInFailState extends SignInState {
  const SignInFailState(super.result, super.state, this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class SignInSuccessState extends SignInState {
  const SignInSuccessState(super.result, super.state);
}

class SignInProgressState extends SignInState {
  const SignInProgressState(super.result, super.state);
}
