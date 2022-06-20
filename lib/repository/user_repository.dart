import 'dart:io';
import '../models/User.dart';

abstract class MyUserRepositoryBase {
  Future<MyUser?> getUser();
  Future<void> saveUser(MyUser user, File? image);
}