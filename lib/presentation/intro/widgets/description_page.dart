import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage(
      {Key? key,
      required this.text,
      required this.imagePath,
      required this.title})
      : super(key: key);

  final String text;
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white38,
              Colors.yellow,
            ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Image.asset(
              imagePath,
              width: 250,
              height: 250,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}
