import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.name,
    required this.description,
    required this.email,
    required this.address,
    required this.phone,
    required this.web,
    //required this.user
  }) : super(key: key);

  //final MyUser user;
  final String name;
  final String description;
  final String email;
  final String address;
  final String? phone;
  final String? web;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(email),
          const SizedBox(height: 8),
          Text(address),
          phone != null ? Text(phone!) : const SizedBox(),
          const SizedBox(height: 8),
          web != null ? Text(web!) : const SizedBox(),
        ],
      ),
    );
  }
}
