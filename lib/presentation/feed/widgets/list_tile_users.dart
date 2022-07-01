import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListTileUser extends StatelessWidget {
  ListTileUser({
    Key? key,
    required this.name, 
    required this.description,
    this.onTap
  }) : super(key: key);

  final String name;
  final String description;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        constraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 64,
          maxHeight: 64,
        ),
        child: Image.asset("assets/user.png"),
      ),
      title: Text(name),
      subtitle: Text(description),
      onTap: onTap,
    );
  }
}