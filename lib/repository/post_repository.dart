import 'dart:io';

import 'package:silver_heart/models/models.dart';

/// Funciones, una retorna un post y la otra los crea
abstract class PostRepositoryBase {
  Future<Post?> getPost();
  Future<void> savePost(Post post, File? image);
}