import 'package:flutter/material.dart';
import 'package:silver_heart/models/my_user.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProfileBottom extends StatelessWidget {
  const ProfileBottom({Key? key, required this.user}) : super(key: key);

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Text(
      user.web,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryColor
      ),
      textAlign: TextAlign.center,
    );
  }
}