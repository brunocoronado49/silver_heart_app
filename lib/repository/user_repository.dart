import 'dart:io';
import '../models/my_user.dart';

abstract class MyUserRepositoryBase {
  Future<MyUser?> getUser();
  Future<void> saveUser(MyUser user, File? image);
}