import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:silver_heart/src/core/errors/exceptions.dart';

abstract class IAuthFirebaseDataSource {
  // get current user
  Future<User> getSignedUser();
  // firebase signed email and pass
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
  });

  // sign in with credentials
  Future<void> signInWithCredential(AuthCredential credential);
  // reset password
  Future<void> resetPassword(String email);
  // logout app
  Future<void> signOut();
}

@Injectable(as: IAuthFirebaseDataSource)
class AuthFirebaseDataSource implements IAuthFirebaseDataSource {
  AuthFirebaseDataSource(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<User> getSignedUser() async {
    final user = _firebaseAuth.currentUser;

    if(user != null) {
      return user;
    } else {
      throw FirebaseExceptions("Inicia sesión nuevamente por favor!");
    }
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (error) {
      String message = "Error inesparado";

      if(error.code == "invalid-email" || error.code == "wrong-password") {
        message = "Correo o contraseña inválidos";
      } else if (error.code == "user-not-found" || error.code == "user-disabled") {
        message = "Usuario deshabilitado o inexistente";
      }
      throw FirebaseExceptions(message);
    }
  }

  @override
  Future<void> signInWithCredential(AuthCredential credential) async {
    try {
      await _firebaseAuth.signOut();
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      String message = "Error inesperado";

      if(error.code == "nvalid-email" || error.code == "wrong-password") {
        message = "Correo o contraseña inválidos";
      } else if (error.code == "user-not-found" || error.code == "user-disabled") {
        message = "Usuario deshabilitado o inexistente";
      }
      throw FirebaseExceptions(message);
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
      return;
    } catch(error) {
      throw FirebaseExceptions("Hubo un error al recuperar contraseña");
    }
  }

  @override
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}