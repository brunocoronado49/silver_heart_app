import 'package:flutter/material.dart';

import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/user/widgets/user_widgets.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.email,
    required this.phone,
    required this.address,
    required this.web,
    required this.user,
    required this.image,
  }) : super(key: key);

  final String name;
  final String description;
  final String email;
  final String phone;
  final String address;
  final String web;
  final String image;
  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_outlined),
            onPressed: () {},
          ),
        ],
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
            phone: phone,
            address: address,
            web: web,
          ),
          const UserSocialMedia(),
          const SizedBox(height: 30),
          const HeaderTitle(title: "Todos los productos"),
          const SizedBox(height: 10),
          UserPosts(seller: name, user: user)
        ],
      ),
    );
  }
}
