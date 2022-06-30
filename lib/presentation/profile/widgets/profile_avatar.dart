import 'package:flutter/material.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key, required this.user}) : super(key: key);

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: AppTheme.thirdColor,
        radius: 70,
        child: user.image != null ?
          Image.network(user.image.toString()) : 
          const Icon(
          Icons.person_outlined,
          color: AppTheme.primaryColor,
          size: 100,
        ),
      ),
    );
  }
}