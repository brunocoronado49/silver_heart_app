import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:silver_heart/core/helpers/carousel_options.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProfilePosts extends StatefulWidget {
  const ProfilePosts({Key? key, required this.user}) : super(key: key);

  final MyUser user;

  @override
  State<ProfilePosts> createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  final Stream<QuerySnapshot> _postStream =
      FirebaseFirestore.instance.collection("post").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _postStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return CarouselSlider(
          options: Carousel.options,
          items: snapshot.data?.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

            return data["seller"] == widget.user.name ? Builder(
              builder: (BuildContext context) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: AppTheme.backgroundColor,
                  child: ListTile(
                    leading: Container(
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: Image.asset("assets/brazalete.png"),
                    ),
                    title: Text(data["name"]),
                    subtitle: Text("${data['description']} - ${data['seller']}"),
                    trailing: Text(data["price"]),
                  ),
                );
              },
            ) : const SizedBox();
          }).toList() ?? [],
        );
      },
    );
  }
}
