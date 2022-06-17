import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 5.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              iconSize: 40.0,
              onPressed: () async {
                  await auth.signOut();
                },
              icon: const Icon(Icons.menu_outlined)
          ),
          Row(
            children: [
              IconButton(
                  iconSize: 40.0,
                  onPressed: () {},
                  icon: const Icon(Icons.search)
              ),
              IconButton(
                  iconSize: 40.0,
                  onPressed: () {},
                  icon: const Icon(Icons.settings)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
