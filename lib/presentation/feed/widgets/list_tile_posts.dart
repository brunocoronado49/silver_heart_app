import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListTilePost extends StatelessWidget {
  ListTilePost({
    Key? key,
    required this.title, 
    required this.seller,
    required this.price,
    this.onTap
  }) : super(key: key);

  final String title;
  final String seller;
  final String price;
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
        child: Image.asset("assets/brazalete.png"),
      ),
      title: Text(title),
      subtitle: Text(seller),
      trailing: Text(price),
      onTap: onTap,
    );
  }
}