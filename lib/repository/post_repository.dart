import 'dart:io';

import '../models/posts/post.dart';

abstract class PostRepositoryBase {
  Future<Post?> getPost();
  Future<void> savePost(Post post, File? image);
}