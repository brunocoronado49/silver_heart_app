import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/repository/user_repository.dart';
import '../../models/User.dart';

part 'user_state.dart';

class UserBloc extends Cubit<UserState> {
  UserBloc(this._userRepositoryBase) : super(UserStateLoading());

  final MyUserRepositoryBase _userRepositoryBase;
  File? _pickedImage;
  late MyUser _user;

  void setImage(File? imageFile) async {
    _pickedImage = imageFile;
    emit(UserStateReady(_user, _pickedImage));
  }

  Future<void> getUser() async {
    emit(UserStateLoading());
    _user = (await _userRepositoryBase.getUser()) ?? MyUser('', '', '', 0);
    emit(UserStateReady(_user, _pickedImage));
  }

  Future<void> saveMyUser(
    String uid,
    String name,
    String lastName,
    int age,
  ) async {
    _user = MyUser(uid, name, lastName, age, image: _user.image);
    emit(UserStateReady(_user, _pickedImage, isSaving: true));
    await Future.delayed(const Duration(seconds: 3));
    await _userRepositoryBase.saveUser(_user, _pickedImage);
    emit(UserStateReady(_user, _pickedImage));
  }
}
