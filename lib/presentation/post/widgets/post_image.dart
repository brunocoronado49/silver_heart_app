import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  const PostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Image.asset("assets/brazalete.png", width: 200),
    );
  }
}