part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthStateInitial extends AuthState {}

class AuthStateError extends AuthState {
  AuthStateError(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

class AuthStateSigninIn extends AuthState {}

class AuthStateSignedOut extends AuthState {}

class AuthStateSingedIn extends AuthState {
  AuthStateSingedIn(this.user);

  final AuthUser user;

  @override
  List<Object?> get props => [user];
}