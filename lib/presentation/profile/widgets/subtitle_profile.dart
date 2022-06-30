import 'package:flutter/material.dart';

class SubtitleProfile extends StatelessWidget {
  const SubtitleProfile({Key? key, required this.subtitle}) : super(key: key);
  
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Text(
        subtitle,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}
