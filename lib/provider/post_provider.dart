import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'package:silver_heart/models/posts/post.dart';

class PostProvider {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  FirebaseStorage get storage => FirebaseStorage.instance;

  User? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Not authenticated!");
    return user;
  }

  Future<Post?> getPost() async {
    final snapshot = await firestore.doc("post/${currentUser?.uid}").get();

    if (snapshot.exists) return Post.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  Future<void> savePost(Post post, File? image) async {
    final ref = firestore.doc("post/${currentUser?.uid}");

    if (image != null) {
      final imagePath =
        '${currentUser?.uid}/post/${path.basename(image.path)}';
      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      await ref.set(post.toFirebaseMap(newImage: url), SetOptions(merge: true));
    } else {
      await ref.set(post.toFirebaseMap(), SetOptions(merge: true));
    }
  }
}