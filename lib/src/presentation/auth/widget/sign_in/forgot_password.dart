import 'package:flutter/material.dart';

class ForgotPAssword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: InkWell(
        child: const Text(
          "¿Olvidaste tu contraseña?",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () {
          print("Navegar hasta la pantalla de recuperar contraseña");
        },
      ),
    );
  }
}
