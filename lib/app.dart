import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/routes/routes.dart';
import 'package:silver_heart/theme/app_theme.dart';

/// Navegacion para identificar las pantallas de la app
final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static Widget create() {

    /// Este metodo retorna un bloc consumer, que dependiendo del estado
    /// nod va a mandar a una vista u otra
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSignedOut) {
          _navigatorKey.currentState?.pushNamedAndRemoveUntil(
            Routes.intro, (r) => false
          );
        } else if (state is AuthStateSingedIn) {
          _navigatorKey.currentState?.pushNamedAndRemoveUntil(
            Routes.home, (r) => false
          );
        }
      },
      builder: (context, state) {
        return const MyApp();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: "Silver heart",
      onGenerateRoute: Routes.routes,
      theme: AppTheme.lightTheme,
    );
  }
}