import 'package:flutter/material.dart';
import 'package:silver_heart/models/my_user.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key, required this.user}) : super(key: key);

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 70,
        child: Image.asset("assets/avatar.png", width: 100)
      ),
    );
  }
}