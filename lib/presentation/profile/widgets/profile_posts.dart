import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:silver_heart/models/models.dart';

class ProfilePosts extends StatefulWidget {
  const ProfilePosts({Key? key, required this.user, this.post})
      : super(key: key);

  final MyUser user;
  final Post? post;

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
          options: CarouselOptions(
            height: 100,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: snapshot.data?.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

            return data["seller"] == widget.user.name ? Builder(
              builder: (BuildContext context) {
                return Card(
                  child: ListTile(
                    title: Text(data["name"].toString()),
                    subtitle: Text("${data['description']} - ${data['seller']}"),
                    trailing: Text(data["price"].toString()),
                  ),
                );
              },
            ) : Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Sin publicaciones",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }).toList() ?? [],
        );
      },
    );
  }
}
