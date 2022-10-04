import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_repository.dart';

class AuthRepository extends AuthRepositoryBase {
  final _auth = FirebaseAuth.instance;

  AuthUser? _userFromFirebase(User? user) => user == null ? null : AuthUser(user.uid);

  /// Maneja los estados del usuario
  @override
  Stream<AuthUser?> get onAuthStateChanged => _auth.authStateChanges().asyncMap(_userFromFirebase);

  /// Funcion para crear un usuario con su correo y contraseña
  /// tomando la funcion de firebase
  @override
  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  /// Funcion para loggear con correo y contraseña usando el metodo de fierbase
  @override
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  /// Loggea con cuenta de Google, actualmente no funcional
  @override
  Future<AuthUser?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    final authResult = await _auth.signInWithCredential(credentials);
    return _userFromFirebase(authResult.user);
  }

  /// Elimina la sesión del usuario
  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}