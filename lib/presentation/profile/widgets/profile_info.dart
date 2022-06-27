import 'package:flutter/material.dart';
import 'package:silver_heart/models/my_user.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key, required this.user}) : super(key: key);

  final MyUser user;

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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          Text(user.email),
          const SizedBox(height: 8),
          Text("${user.address} ${user.phone}"),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
