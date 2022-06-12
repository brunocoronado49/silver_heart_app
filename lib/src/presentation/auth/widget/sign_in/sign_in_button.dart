import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton(this._signInFunction);

  final Function _signInFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: _signInFunction(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: const Text(
          "Entrar",
          style: TextStyle(
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}