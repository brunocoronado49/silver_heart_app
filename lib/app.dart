import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/src/presentation/home/view/home_page.dart';
import 'package:silver_heart/src/presentation/login/view/login_page.dart';
import 'src/repository/repository.dart';
import 'src/auth/auth.dart';
import 'src/presentation/slpash/splash_screen.dart';
import 'src/core/styles/styles.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.authRepository}) : super(key: key);

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthBloc(authRepository: authRepository),
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigationKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigationKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: styles.appTheme,
      navigatorKey: _navigationKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              switch(state.status) {
                case AuthStateStatus.authenticated:
                  _navigator?.pushAndRemoveUntil<void>(
                      HomePage.route(), (route) => false
                  ); break;
                case AuthStateStatus.unaunthenticated:
                  _navigator?.pushAndRemoveUntil<void>(
                      LoginPage.route(), (route) => false
                  );
                  break;
                default: break;
              }
            },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
