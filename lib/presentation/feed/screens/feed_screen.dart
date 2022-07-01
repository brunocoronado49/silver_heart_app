import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:silver_heart/presentation/feed/widgets/feed_widgets.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';

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
    return SafeArea(
      child: StreamBuilder(
        stream: _postStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const ErrorText(error: "Error al tomar posts");
          }
    
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgress();
          }
    
          return ListView(
            padding: const EdgeInsets.all(10),
            children: const [
              HeaderTitle(title: "Productos"),
              ProductsItems(),
              HeaderTitle(title: "Ofertas"),
              ProductsItems(),
              HeaderTitle(title: "Usuarios"),
              UsersItems(),
            ],
          );
        },
      ),
    );
  }
}
