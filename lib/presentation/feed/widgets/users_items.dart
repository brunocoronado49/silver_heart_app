import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:silver_heart/core/helpers/carousel_options.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/profile/screens/profile_screen.dart';
import 'package:silver_heart/presentation/user/screens/user_detail_screen.dart';

class UsersItems extends StatefulWidget {
  const UsersItems({Key? key, required this.user}) : super(key: key);

  final MyUser user;

  @override
  State<UsersItems> createState() => _UsersItemsState();
}

class _UsersItemsState extends State<UsersItems> {
  final Stream<QuerySnapshot> _user = FirebaseFirestore.instance
      .collection("user")
      //.where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: StreamBuilder(
        stream: _user,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return CarouselSlider(
            options: Carousel.options,
            items: snapshot.data?.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  if (data["seller"] != widget.user.name) {
                                    return UserDetailScreen(
                                      name: data["name"],
                                      description: data["description"],
                                      email: data["email"],
                                      phone: data["phone"],
                                      web: data["web"],
                                      address: data["address"],
                                      image: data["image"],
                                      user: widget.user,
                                    );
                                  } else {
                                    return const ProfileScreen();
                                  }
                                }));
                              },
                              child: Center(
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: CachedNetworkImage(
                                      imageUrl: data["image"],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(data["name"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList() ??
                [const Text("Sin usuarios")],
          );
        },
      ),
    );
  }
}
