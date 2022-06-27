part of 'create_post_bloc.dart';

abstract class CreatePostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreatePostInitialState extends CreatePostState {}

class CreatePostLoadingState extends CreatePostState {}

class CreatePostErrorState extends CreatePostState {
  CreatePostErrorState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];

}

class CreatePostSavedState extends CreatePostState {
  CreatePostSavedState(this.post, this.pickedImage, {this.isSaving = false});

  final Post post;
  final File? pickedImage;
  final bool isSaving;

  @override
  List<Object?> get props => [post, pickedImage?.path, isSaving];
}

class CreatePostReadyState extends CreatePostState {}
