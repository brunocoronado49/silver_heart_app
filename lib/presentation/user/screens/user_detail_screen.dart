import 'package:flutter/material.dart';

import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/user/widgets/user_widgets.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.email,
    this.phone,
    required this.address,
    this.web,
    required this.user,
    this.image,
  }) : super(key: key);

  final String name;
  final String description;
  final String email;
  final String? phone;
  final String address;
  final String? web;
  final String? image;
  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name)
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: UserAvatar(avatar: image)
          ),
          UserInfo(
            name: name,
            description: description,
            email: email,
            phone: phone ?? "",
            address: address,
            web: web ?? "",
          ),
          const UserSocialMedia(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
