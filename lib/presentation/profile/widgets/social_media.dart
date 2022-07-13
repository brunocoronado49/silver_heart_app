import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 30;

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/facebook-icon.png", width: width),
          const SizedBox(width: 50),
          Image.asset("assets/twitter-icon.png", width: width),
          const SizedBox(width: 50),
          Image.asset("assets/whats-icon.png", width: width),
          const SizedBox(width: 50),
          Image.asset("assets/instagram-icon.png", width: width),
          const SizedBox(width: 50),
        ],
      ),
    );
  }
}
