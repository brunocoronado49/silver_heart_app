import 'package:flutter/material.dart';
import 'package:silver_heart/theme/app_theme.dart';

// ignore: must_be_immutable
class ListTileUser extends StatelessWidget {
  ListTileUser(
      {Key? key,
      required this.name,
      required this.description,
      this.onTap,
      this.avatar})
      : super(key: key);

  final String name;
  final String description;
  final String? avatar;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: CircleAvatar(
          backgroundColor: AppTheme.thirdColor,
          child: avatar != null
            ? Image.network(avatar!)
            : Image.asset("assets/profile-user.png"),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Text(description),
      onTap: onTap,
    );
  }
}
