import 'package:flutter/material.dart';
import 'package:silver_heart/src/presentation/auth/view/sign_in.dart';

class SignInButton extends StatelessWidget {
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
              fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const SignIn()
          ));
        },
      ),
    );
  }
}
