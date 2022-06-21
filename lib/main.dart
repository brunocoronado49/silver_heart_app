import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/bloc/auth_bloc/auth_bloc.dart';
import 'package:silver_heart/repository/implementations/auth_repository_implement.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authCubit = AuthCubit(AuthRepository());
  EquatableConfig.stringify = true;

  runApp(
    BlocProvider(
      create: (_) => authCubit..init(),
      child: MyApp.create(),
    )
  );
}
