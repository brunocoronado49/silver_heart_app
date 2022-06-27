import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:silver_heart/presentation/widgets/circular_progress.dart';
import 'package:silver_heart/presentation/widgets/error_text.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final Stream<QuerySnapshot> _postStream =
    FirebaseFirestore.instance.collection("post").snapshots();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _postStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const ErrorText(error: "Error al tomar posts");
        }
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgress();
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
            
            return Card(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  ListTile(
                    title: Text(data["name"].toString()),
                    subtitle: Text(data["seller"].toString()),
                    onTap: () {},
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}