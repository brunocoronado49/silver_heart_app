import 'dart:io';

import 'package:silver_heart/models/models.dart';
import '../../provider/firebase_provider.dart';
import '../user_repository.dart';

class MyUserRepositoryImplement extends MyUserRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<MyUser?> getUser() => provider.getUser();

  @override
  Future<void> saveUser(MyUser user, File? image) => provider.saveUser(user, image);
}
