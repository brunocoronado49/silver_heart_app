import 'dart:io';

import 'package:silver_heart/models/models.dart';

abstract class PostRepositoryBase {
  Future<Post?> getPost();
  Future<void> savePost(Post post, File? image);
}