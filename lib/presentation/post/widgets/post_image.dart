import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

class PostImage extends StatefulWidget {
  const PostImage(
      {Key? key, required this.imageUrl, required this.uid, required this.type})
      : super(key: key);

  final String imageUrl;
  final String uid;
  final String type;

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  List<ImageProvider> imageList = <ImageProvider>[];
  bool autoRotate = true;
  int rotationCount = 2;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = const Duration(milliseconds: 50);
  bool imagePrecached = false;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
  }

  void updateImageList(BuildContext context) async {
    var result = await FirebaseStorage.instance
        .ref()
        .child("images/${widget.uid}/${widget.type}/")
        .listAll();
    var allImages = result.items;

    await Future.forEach<Reference>(allImages, (image) async {
      String url = await image.getDownloadURL();
      for (int i = 1; i <= allImages.length; i++) {
        imageList.add(NetworkImage(url));
        // ignore: use_build_context_synchronously
        await precacheImage(NetworkImage(url), context);
      }
    });
    setState(() {
      imagePrecached = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (imagePrecached == true)
              ? ImageView360(
                  key: UniqueKey(),
                  imageList: imageList,
                  autoRotate: autoRotate,
                  rotationCount: rotationCount,
                  rotationDirection: RotationDirection.anticlockwise,
                  frameChangeDuration: const Duration(milliseconds: 30),
                  swipeSensitivity: swipeSensitivity,
                  allowSwipeToRotate: allowSwipeToRotate,
                )
              : const Text("Cargando imágen del producto..."),
        ],
      ),
    );
  }
}
