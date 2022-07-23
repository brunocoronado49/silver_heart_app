import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/search/widgets/list_tile_user.dart';
import 'package:silver_heart/presentation/search/widgets/search_header.dart';
import 'package:silver_heart/presentation/user/screens/user_detail_screen.dart';

import 'package:silver_heart/presentation/widgets/widgets.dart';
import 'package:silver_heart/theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.user}) : super(key: key);

  final MyUser user;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
      .collection("user")
      .where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const ErrorText(error: "Error al tomar usuario");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgress();
          }

          return SafeArea(
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: AppTheme.backgroundColor,
                        child: Column(
                          children: [
                            FadeInImage(
                              image: NetworkImage(data["image"]),
                              placeholder:
                                  const AssetImage("assets/loading.gif"),
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 300),
                            ),
                            ListTileUser(
                                name: data["name"],
                                description: data["description"],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserDetailScreen(
                                                name: data["name"],
                                                description:
                                                    data["description"],
                                                email: data["email"],
                                                phone: data["phone"],
                                                web: data["web"],
                                                address: data["address"],
                                                image: data["image"],
                                                user: widget.user,
                                              )));
                                }),
                          ],
                        ),
                      ),
                    );
                  }).toList() ??
                  [],
            ),
          );
        });
  }
}
