import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:pedantic/pedantic.dart';
import '../../repository/repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unknown()) {
          _userSubscription = _authRepository.user
          .listen((user) => add(AuthUserChanges(user)));
        }

  final AuthRepository _authRepository;
  late StreamSubscription<User> _userSubscription;

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthUserChanges){
      yield _mapAuthUserChangedToState(event);
    } else if (event is AuthLogoutRequested) {
      unawaited(_authRepository.logOut());
    }
  }

  AuthState _mapAuthUserChangedToState(AuthUserChanges event) {
    return event.user != User.empty ?
    AuthState.authenticated(event.user) : const AuthState.unaunthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

}

