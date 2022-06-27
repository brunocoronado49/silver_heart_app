import 'package:flutter/material.dart';
import 'package:silver_heart/models/my_user.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({Key? key, required this.user}) : super(key: key);

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Text(
      user.name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
    );
  }
}