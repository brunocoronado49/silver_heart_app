import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' as storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class MultiImagesScreen extends StatefulWidget {
  const MultiImagesScreen({Key? key}) : super(key: key);

  @override
  State<MultiImagesScreen> createState() => _MultiImagesScreenState();
}

class _MultiImagesScreenState extends State<MultiImagesScreen> {
  bool uploading = false;
  double val = 0;
  late storage.CollectionReference imgRef;
  final storageRef = FirebaseStorage.instance;

  List<File> _image = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add multiple images"),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  uploading = true;
                });
                uploadFile().whenComplete(() => Navigator.of(context).pop());
              },
              child: const Text(
                'upload',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: GridView.builder(
              itemCount: _image.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => !uploading ? chooseImage() : null),
                      )
                    : Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_image[index - 1]),
                                fit: BoxFit.cover)),
                      );
              },
            ),
          ),
          uploading
              ? Center(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        'uploading...',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(
                      value: val,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.black),
                    )
                  ],
                ))
              : Container(),
        ],
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future<void> uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });

      Reference refe = storageRef.ref().child('images/${FirebaseAuth.instance.currentUser!.uid}/$i/${Path.basename(img.path)}');

      UploadTask uploadTask = refe.putFile(img);

      await uploadTask.then((res) async {
        await res.ref.getDownloadURL().then((value) async {
          imgRef.add({"url": value});
          i++;
        });
      });

      // await storageRef.ref().putFile(img).whenComplete(() async {
      //   await stref.getDownloadURL().then((value) {
      //     imgRef.add({"url": value});
      //     i++;
      //   });
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = storage.FirebaseFirestore.instance.collection('imageURLs');
  }
}
