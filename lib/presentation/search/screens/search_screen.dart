import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:silver_heart/presentation/widgets/circular_progress.dart';
import 'package:silver_heart/presentation/widgets/error_text.dart';

class Searchcreen extends StatefulWidget {
  const Searchcreen({Key? key}) : super(key: key);

  @override
  State<Searchcreen> createState() => _SearchcreenState();
}

class _SearchcreenState extends State<Searchcreen> {
  final Stream<QuerySnapshot> _userStream =
    FirebaseFirestore.instance.collection("user").snapshots();

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
                    subtitle: Text(data["description"].toString()),
                    onTap: () {},
                  ),
                ],
              ),
            );
          }).toList()
        );
      },
    );
  }
}