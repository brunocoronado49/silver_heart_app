import 'package:flutter/material.dart';
import 'package:silver_heart/models/models.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key, required this.name, required this.description, required this.price, required this.seller}) : super(key: key);

  final String name;
  final String description;
  final String price;
  final String seller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Text(name),
            Text(description),
            Text(price),
            Text(seller),
          ],
        ),
      ),
    );
  }
}