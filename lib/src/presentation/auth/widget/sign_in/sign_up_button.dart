import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
          print("redirigir a pantalla de registro");
        },
      ),
    );
  }
}
