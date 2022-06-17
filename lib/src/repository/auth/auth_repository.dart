import 'dart:async';
import 'dart:js_util/js_util_wasm.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import '../model/User.dart';

/// Maneja error al registrarse
class SignUpFailure implements Exception {}

/// Error al iniciar sesion
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Error con el login de google
class LogInWithGoogleFailure implements Exception {}

/// Error al cerrar sesion
class LogOutFailure implements Exception {}

class AuthRepository {
  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn
  }) : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
  _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn? _googleSignIn;

  /// El stream user es el usuario actual cuando el estado cambia
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

  /// Registro de usuario con correo y contraseña
  Future<void> signUp({
    required String email,
    required String password
  }) async {
    assert(email != null, password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  /// Iniciar sesion con correo y contraseña
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    assert(email != null, password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Iniciar sesion con google
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn?.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  /// Cerrar sesion
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn!.signOut()
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }

}

extension on auth.User {
  User get toUser {
    return User(id: uid, name: displayName, email: email.toString(), photo: photoURL);
  }
}