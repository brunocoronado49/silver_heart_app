import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependences() async {
  final prefs = getIt<SharedPreferences>();
  if (prefs.getBool('first_run') ?? true) {
    await FirebaseAuth.instance.signOut();

    prefs.setBool('first_run', false);
  }
}