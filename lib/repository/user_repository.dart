import 'dart:io';

import 'package:silver_heart/models/models.dart';


abstract class MyUserRepositoryBase {
  Future<MyUser?> getUser();
  Future<void> saveUser(MyUser user, File? image);
}