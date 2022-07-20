import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/search/widgets/search_header.dart';
import 'package:silver_heart/presentation/user/screens/user_detail_screen.dart';

import 'package:silver_heart/presentation/widgets/widgets.dart';
import 'package:silver_heart/theme/app_theme.dart';

class Searchcreen extends StatefulWidget {
  const Searchcreen({Key? key, required this.user}) : super(key: key);

  final MyUser user;

  @override
  State<Searchcreen> createState() => _SearchcreenState();
}

class _SearchcreenState extends State<Searchcreen> {
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

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: AppTheme.backgroundColor,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          constraints: const BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: AppTheme.thirdColor,
                              child: ClipOval(
                                child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                        data["image"].toString())),
                              ),
                            ),
                          ),
                        ),
                        title: Text(data["name"].toString()),
                        subtitle: Text(data["description"].toString()),
                        trailing: Column(
                          children: [Text(data["email"]), Text(data["phone"])],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailScreen(
                                        name: data["name"],
                                        description: data["description"],
                                        email: data["email"],
                                        phone: data["phone"],
                                        web: data["web"],
                                        address: data["address"],
                                        image: data["image"],
                                        user: widget.user,
                                      )));
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        });
  }
}
