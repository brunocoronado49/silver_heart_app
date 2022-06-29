import 'package:flutter/material.dart';

import 'package:silver_heart/presentation/screens.dart';

class Routes {
  static const splash = "/";
  static const signIn = "/sign-in";
  static const signUp = "/sign-up";
  static const intro = "/intro";
  static const home = "/home";

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case signIn:
        return _buildRoute(SignInScreen.create);
      case signUp:
        return _buildRoute(SignUpScreen.create);
      case home:
        return _buildRoute(HomeScreen.create);
      case intro:
        return _buildRoute(IntroScreen.create);
      default:
        throw Exception('La ruta no existe!');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
