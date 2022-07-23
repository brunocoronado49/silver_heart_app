import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart';

class LiistUploadPostsScreen extends StatefulWidget {
   
  const LiistUploadPostsScreen({Key? key}) : super(key: key);

  @override
  State<LiistUploadPostsScreen> createState() => _LiistUploadPostsScreenState();
}

class _LiistUploadPostsScreenState extends State<LiistUploadPostsScreen> {
  late List<Asset>? images;
  late String? _error;

  @override
  void initState() {
    _error = "";
    images = null;
    super.initState();
  }

  Widget buildGridView() {
    if (images != null) {
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images!.length, (index) {
          Asset asset = images![index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    } else {
      return Container(color: Colors.white);
    }
  }

  Future<void> loadAssets() async {
    setState(() {});

    List<Asset>? resultList;
    String? error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 50,
        enableCamera: true,
        materialOptions: const MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(child: Text('Error: $_error')),
            TextButton(
              onPressed: loadAssets,
              child: const Text("Pick images"),
            ),
            Expanded(
              child: buildGridView(),
            ),
            TextButton(
              child: const Text("upload"),
              onPressed: () {},
            ),
          ],
        ),
      );
  }
}