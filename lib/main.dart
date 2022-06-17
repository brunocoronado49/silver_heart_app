import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:silver_heart/src/repository/auth/auth_repository.dart';
import 'app.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = true;
  BlocOverrides.runZoned(
      () => runApp(MyApp(authRepository: AuthRepository())),
      blocObserver: SimpleBlocObserver()
  );
}
