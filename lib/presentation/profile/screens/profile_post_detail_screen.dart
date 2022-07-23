import 'package:flutter/material.dart';
import 'package:silver_heart/presentation/post/widgets/posts_widgets.dart';
import 'package:silver_heart/presentation/profile/widgets/widgets_profile.dart';

class ProfilePostDetailScreen extends StatelessWidget {
  const ProfilePostDetailScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.seller,
    required this.imageUrl,
  }) : super(key: key);

  final String name;
  final String description;
  final String price;
  final String seller;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            PostImage(imageUrl: imageUrl),
            const SizedBox(height: 20),
            ProfilePostInfo(
              name: name,
              price: price,
              description: description,
              seller: seller
            )
          ],
        ),
      ),
    );
  }
}
