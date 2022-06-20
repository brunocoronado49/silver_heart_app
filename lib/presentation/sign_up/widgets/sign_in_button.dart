import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  SignInButton({Key? key}) : super(key: key);

  final _navigationKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigationKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: InkWell(
        child: const Text(
          "¿Ya tienes cuenta? Inicia sesión",
          style: TextStyle(
              color: Colors.black87,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        onTap: () {
          // TODO
        },
      ),
    );
  }
}
