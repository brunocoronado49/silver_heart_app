import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';
import 'package:silver_heart/theme/app_theme.dart';

class OtherApart extends StatefulWidget {
  const OtherApart({Key? key}) : super(key: key);

  @override
  State<OtherApart> createState() => _OtherApartState();
}

class _OtherApartState extends State<OtherApart> {
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

        return Column(
          children :snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

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
                      child: Image.asset("assets/user.png"),
                    ),
                    title: Text(data["name"].toString()),
                    subtitle: Text(data["description"].toString()),
                    trailing: Column(
                      children: [
                        Text(data["email"]),
                        Text(data["phone"])
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            );
          }).toList() ?? [],
        );
      }
    );
  }
}