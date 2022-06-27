import 'dart:io';

import '../user_repository.dart';
import '../../provider/firebase_provider.dart';
import '../../models/my_user.dart';

class MyUserRepositoryImplement extends MyUserRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<MyUser?> getUser() => provider.getUser();

  @override
  Future<void> saveUser(MyUser user, File? image) => provider.saveUser(user, image);
}
