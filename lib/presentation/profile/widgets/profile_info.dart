import 'package:flutter/material.dart';
import 'package:silver_heart/models/my_user.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key, required this.user}) : super(key: key);

  final MyUser user;
  final color = AppTheme.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            user.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 20),
          Text(user.email, style: TextStyle(color: color)),
          const SizedBox(height: 8),
          Text("${user.address}, ${user.phone}",
              style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
