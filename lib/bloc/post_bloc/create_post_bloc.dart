import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/models/posts/post.dart';
import 'package:silver_heart/repository/post_repository.dart';

part 'create_post_state.dart';

class CreatePostBloc extends Cubit<CreatePostState> {
  CreatePostBloc(this._postRepositoryBase) : super(CreatePostInitialState());

  final PostRepositoryBase _postRepositoryBase;
  File? _pickedImage;
  Post? _post;

  void setImage(File? imageFile) async {
    _pickedImage = imageFile;
    emit(CreatePostSavedState(_post!, _pickedImage));
  }

  Future<void> getPost() async {
    emit(CreatePostLoadingState());
    _post = (await _postRepositoryBase.getPost()) ??
    const Post('', '', '', '', '', '', '');
    emit(CreatePostSavedState(_post!, _pickedImage));
  }

  Future<void> savePost(
    String id,
    String price,
    String type,
    String name,
    String description,
    String seller,
    String uid
  ) async {
    _post = Post(id, price, type, name, description, seller, uid, picture: _post?.picture);
    emit(CreatePostSavedState(_post!, _pickedImage, isSaving: true));
    await Future.delayed(const Duration(seconds: 3));
    await _postRepositoryBase.savePost(_post!, _pickedImage);
    emit(CreatePostReadyState());
    emit(CreatePostSavedState(_post!, _pickedImage, isSaving: false));
  }
}