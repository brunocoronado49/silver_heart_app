import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser(this.uid);

  final String uid;
  
  @override
  List<Object?> get props => [uid];
}

/// Funciones con las que vamos a manejar la logica de firebase
/// y vamos a consumir sus servicios
abstract class AuthRepositoryBase {
  Stream<AuthUser?> get onAuthStateChanged;

  Future<AuthUser?> signInWithEmailAndPassword(String email, String password);
  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password);
  Future<AuthUser?> signInWithGoogle();
  Future<void> signOut();
}