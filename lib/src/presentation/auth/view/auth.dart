import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  late FirebaseAuth auth;

  @override
  void initState(){
    super.initState();
    auth = FirebaseAuth.instance;
  }

  final email = "example@email.com";
  final password = "password";

  Future<void> createAccount() async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    print("account created");
  }

  Future<void> login() async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    print("Logged");
  }

  Future<void> logout() async {
    await auth.signOut();
    print("Revoked user stream token");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: createAccount,
              child: const Text("Create account")
          ),
          ElevatedButton(
              onPressed: login,
              child: const Text("login")
          ),
          ElevatedButton(
              onPressed: logout,
              child: const Text("logout")
          )
        ],
      ),
    );
  }
}
