import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset(
        "assets/pulcera.png",
        width: 300,
        height: 250,
      )
    );
  }
}