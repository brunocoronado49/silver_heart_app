import 'package:flutter/material.dart';

class SignUpImage extends StatelessWidget {
  const SignUpImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset(
        "assets/work.png",
        width: 300,
        height: 250,
      )
    );
  }
}