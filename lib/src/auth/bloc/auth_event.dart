part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserChanges extends AuthEvent {
  const AuthUserChanges(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

class AuthLogoutRequested extends AuthEvent {}