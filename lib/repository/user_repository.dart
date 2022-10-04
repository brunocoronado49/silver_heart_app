import 'dart:io';

import 'package:silver_heart/models/models.dart';

/// Dos funciones, una retorna un usuario y la otra guarda sus datos
abstract class MyUserRepositoryBase {
  Future<MyUser?> getUser();
  Future<void> saveUser(MyUser user, File? image);
}