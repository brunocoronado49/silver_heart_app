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
      title: Text(title),
      subtitle: Text(seller),
      trailing: Text(price),
      onTap: onTap,
    );
  }
}