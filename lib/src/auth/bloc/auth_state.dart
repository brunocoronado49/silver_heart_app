part of 'auth_bloc.dart';

enum AuthStateStatus {
  authenticated,
  unaunthenticated,
  unknow
}

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStateStatus.unknow,
    this.user
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user) :
      this._(status: AuthStateStatus.authenticated, user: user);

  const AuthState.unaunthenticated() :
      this._(status: AuthStateStatus.unaunthenticated);

  final AuthStateStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}