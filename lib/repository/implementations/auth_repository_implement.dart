import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_repository.dart';

class AuthRepository extends AuthRepositoryBase {
  final _auth = FirebaseAuth.instance;

  AuthUser? _userFromFirebase(User? user) => user == null ? null : AuthUser(user.uid);

  @override
  Stream<AuthUser?> get onAuthStateChanged => _auth.authStateChanges().asyncMap(_userFromFirebase);

  @override
  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

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

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}