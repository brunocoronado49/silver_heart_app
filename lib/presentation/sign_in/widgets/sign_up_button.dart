import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

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
