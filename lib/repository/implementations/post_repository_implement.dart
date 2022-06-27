import 'dart:io';

import '../post_repository.dart';
import '../../provider/post_provider.dart';
import '../../models/posts/post.dart';

class PostRepositoryImplements extends PostRepositoryBase {
  final provider = PostProvider();

  @override
  Future<Post?> getPost() => provider.getPost();

  @override
  Future<void> savePost(Post post, File? image) => provider.savePost(post, image);

}