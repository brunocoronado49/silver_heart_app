import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transparent_image/transparent_image.dart';

import 'multi_images_screen.dart';

class MultiImagesUploadedScreen extends StatefulWidget {
  const MultiImagesUploadedScreen({Key? key}) : super(key: key);

  @override
  State<MultiImagesUploadedScreen> createState() =>
      _MultiImagesUploadedScreenState();
}

class _MultiImagesUploadedScreenState extends State<MultiImagesUploadedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This show all images"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('imageURLs').snapshots(),
        builder: ((context, snapshot) {
          return !snapshot.hasData ? const Center(
            child: CircularProgressIndicator(),
          ) : Container(
            padding: const EdgeInsets.all(4),
            child: GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(3),
                  child: FadeInImage.memoryNetwork(
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: snapshot.data!.docs[index].get('url')),
                );
              },
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MultiImagesScreen()));
        },
      ),
    );
  }
}
