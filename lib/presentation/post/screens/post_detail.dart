import 'package:flutter/material.dart';
import 'package:silver_heart/presentation/post/widgets/posts_widgets.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.seller,
    required this.imageUrl, required this.type, required this.uid, required this.banc, required this.accountNumber
  }) : super(key: key);

  final String name;
  final String description;
  final String price;
  final String seller;
  final String imageUrl;
  final String type;
  final String uid;
  final String banc;
  final String accountNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            PostImage(imageUrl: imageUrl, uid: uid, type: type),
            const SizedBox(height: 20),
            PostInfo(
              name: name,
              price: price,
              description: description,
              seller: seller,
              banc: banc,
              accountNumber: accountNumber,
            ),
          ],
        ),
      ),
    );
  }
}
