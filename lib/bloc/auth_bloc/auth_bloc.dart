import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/repository/auth_repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthStateInitial());

  final AuthRepositoryBase _authRepository;
  late StreamSubscription _authSubscription;
  
  void init() {
    //await Future.delayed(const Duration(seconds: 3));
    _authSubscription = _authRepository.onAuthStateChanged.listen(_authStateChanged);
  }

  void _authStateChanged(AuthUser? user) {
    user == null ? emit(AuthStateSignedOut()) : emit(AuthStateSingedIn(user));
  }

  Future<void> reset() async => emit(AuthStateInitial());

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    _signIn(_authRepository.createUserWithEmailAndPassword(email, password));
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _signIn(_authRepository.signInWithEmailAndPassword(email, password));
  }

  Future<void> signInWithGoogle() => _signIn(_authRepository.signInWithGoogle());

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
    await _authRepository.signOut();
    emit(AuthStateSignedOut());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}