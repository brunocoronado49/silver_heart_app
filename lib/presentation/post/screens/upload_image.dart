import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UploadImageScreen extends StatefulWidget {
   
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class _UploadImageScreenState extends State<UploadImageScreen> {
  late File? _imageFile;

  @override
  void initState() {
    _imageFile = null;
    super.initState();
  }

  final picker = ImagePicker();

  // Get the image
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future<void> uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile!.path);
    final ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
    ref.putFile(_imageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subir imágen"),
      ),
      body: Stack(
        children: [
          Container(
            height: 360,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0)
              ),
              gradient: LinearGradient(
                colors: [orange, yellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "Sube una imágen a Firebases",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10.0
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
                            ? Image.file(_imageFile!)
                            : IconButton(
                                icon: const Icon(Icons.add_a_photo_outlined),
                                onPressed: pickImage,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          margin: const EdgeInsets.only(
              top: 30, left: 20.0, right: 20.0, bottom: 20.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [yellow, orange],
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: TextButton(
            onPressed: () => uploadImageToFirebase(context),
            child: const Text("Upload image", style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
