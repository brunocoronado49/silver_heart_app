import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/presentation/user/widgets/user_widgets.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.email,
    required this.phone,
    required this.address,
    required this.web,
  }) : super(key: key);

  final String name;
  final String description;
  final String email;
  final String phone;
  final String address;
  final String web;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const UserAvatar()
          ),
          UserInfo(
            name: name,
            description: description,
            email: email,
            phone: phone,
            address: address,
            web: web,
          )
        ],
      ),
    );
  }
}
