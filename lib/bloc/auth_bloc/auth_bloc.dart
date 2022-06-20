import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/repository/auth_repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepositoryBase) : super(AuthStateInitial());

  final AuthRepositoryBase _authRepositoryBase;
  late StreamSubscription _authSubscription;

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 5));
    _authSubscription = _authRepositoryBase.onAuthStateChange.listen(_authStateChanged);
  }

  void _authStateChanged(AuthUser? user) {
    user == null ? emit(AuthStateSignedOut()) : emit(AuthStateSingedIn(user));
  }

  Future<void> reset() async => emit(AuthStateInitial());

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    _signIn(_authRepositoryBase.createUserWithEmailAndPassword(email, password));
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _signIn(_authRepositoryBase.signInWithEmailAndPassword(email, password));
  }

  Future<void> signInWithGoogle() => _signIn(_authRepositoryBase.signInWithGoogle());

  Future<void> _signIn(Future<AuthUser?> auxUser) async {
    try {
      emit(AuthStateSigninIn());
      final user = await auxUser;
      if (user == null) {
        emit(AuthStateError("Error al entrar."));
      } else {
        emit(AuthStateSingedIn(user));
      }
    } catch (error) {
      print("Error: $error");
      emit(AuthStateError(error.toString()));
    }
  }

  Future<void> signOut() async {
    await _authRepositoryBase.signOut();
    emit(AuthStateSignedOut());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}