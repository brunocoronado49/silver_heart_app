import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:silver_heart/core/helpers/carousel_options.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/post/screens/post_detail.dart';
import 'package:silver_heart/presentation/profile/screens/profile_post_detail_screen.dart';
import 'package:silver_heart/theme/app_theme.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({
    Key? key,
    required this.seller,
    required this.user
  }) : super(key: key);

  final String seller;
  final MyUser user;

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  final Stream<QuerySnapshot> _postStream =
    FirebaseFirestore.instance.collection("post")
      .where("userId", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _postStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return CarouselSlider(
          options: Carousel.options,
          items: snapshot.data?.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

            return Builder(
              builder: (BuildContext context) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: AppTheme.backgroundColor,
                  child: Column(
                    children: [
                      const FadeInImage(
                        image: AssetImage("assets/anillo-pexel.jpg"),
                        placeholder: AssetImage("assets/loading.gif"),
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 300),
                      ),
                      ListTile(
                        title: Text(data["name"]),
                        subtitle: Text("${data['description']} - ${data['seller']}"),
                        trailing: Text(data["price"]),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       if (data["seller"] != widget.user.name) {
                          //         return PostDetail(
                          //           name: data["name"],
                          //           description: data["description"],
                          //           seller: data["seller"],
                          //           price: data["price"],
                          //         );
                          //       }
                          //       return ProfilePostDetailScreen(
                          //         name: data["name"],
                          //         description: data["description"],
                          //         seller: data["seller"],
                          //         price: data["price"],
                          //       );
                          //     }
                          //   )
                          // );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList() ?? [],
        );
      },
    );
  }
}
