import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:silver_heart/core/helpers/carousel_options.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/feed/widgets/list_tile_users.dart';
import 'package:silver_heart/presentation/profile/screens/profile_screen.dart';
import 'package:silver_heart/presentation/user/screens/user_detail_screen.dart';
import 'package:silver_heart/theme/app_theme.dart';

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
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: AppTheme.backgroundColor,
                        child: Column(
                          children: [
                            ListTileUser(
                              avatar: data["image"],
                              name: data["name"],
                              description: data["description"],
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
