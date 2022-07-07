import 'package:flutter/material.dart';
import 'package:silver_heart/presentation/post/widgets/posts_widgets.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.seller
  }) : super(key: key);

  final String name;
  final String description;
  final String price;
  final String seller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const PostImage(),
            const SizedBox(height: 50),
            PostInfo(
              name: name,
              price: price,
              description: description,
              seller: seller
            ),
          ],
        ),
      ),
    );
  }
}
