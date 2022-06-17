import 'package:flutter/material.dart';
import 'package:silver_heart/src/presentation/auth/view/sign_up.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: InkWell(
        child: const Text(
          "¿No tienes cuenta? Crea una nueva",
          style: TextStyle(
            color: Colors.black87,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const SignUp()
          ));
        },
      ),
    );
  }
}
