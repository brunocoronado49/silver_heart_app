import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:silver_heart/core/helpers/carousel_options.dart';
import 'package:silver_heart/presentation/feed/widgets/feed_widgets.dart';
import 'package:silver_heart/presentation/user/screens/user_detail_screen.dart';
import 'package:silver_heart/theme/app_theme.dart';

class UsersItems extends StatefulWidget {
  const UsersItems({Key? key}) : super(key: key);

  @override
  State<UsersItems> createState() => _UsersItemsState();
}

class _UsersItemsState extends State<UsersItems> {
  final Stream<QuerySnapshot> _user = 
    FirebaseFirestore.instance.collection("user").snapshots();

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
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: AppTheme.backgroundColor,
                    child: ListTileUser(
                      name: data["name"],
                      description: data["description"],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => 
                              UserDetailScreen(
                                name: data["name"],
                                description: data["description"],
                                email: data["email"],
                                phone: data["phone"],
                                web: data["web"],
                                address: data["address"],
                              )
                          )
                        );
                      },
                    ),
                  );
                },
              );
            }).toList() ?? [],
          );
        },
      ),
    );
  }
}
