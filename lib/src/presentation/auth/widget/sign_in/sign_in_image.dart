import 'package:flutter/material.dart';

class SignInImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Image.asset(
        "assets/logo.png",
        height: MediaQuery.of(context).size.height * 25,
      ),
    );
  }
}