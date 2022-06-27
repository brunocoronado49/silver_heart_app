part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserStateLoading extends UserState {}

class UserStateSaved extends UserState {}

class UserStateReady extends UserState {
  UserStateReady(this.user, this.pickedImage, {this.isSaving = false});

  final MyUser user;
  final File? pickedImage;
  final bool isSaving;

  @override
  List<Object?> get props => [user, pickedImage?.path, isSaving];
}