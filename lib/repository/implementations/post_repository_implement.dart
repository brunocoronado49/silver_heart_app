import 'dart:io';

import 'package:silver_heart/models/models.dart';
import '../../provider/post_provider.dart';
import '../post_repository.dart';

class PostRepositoryImplements extends PostRepositoryBase {
  final provider = PostProvider();

  @override
  Future<Post?> getPost() => provider.getPost();

  @override
  Future<void> savePost(Post post, File? image) => provider.savePost(post, image);

}