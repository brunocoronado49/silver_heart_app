import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser(this.uid);

  final String uid;
  
  @override
  List<Object?> get props => [uid];
}

abstract class AuthRepositoryBase {
  Stream<AuthUser?> get onAuthStateChange;

  Future<AuthUser?> signInWithEmailAndPassword(String email, String password);
  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password);
  Future<AuthUser?> signInWithGoogle();
  Future<void> signOut();
}