import 'package:flutter/material.dart';
import 'package:silver_heart/presentation/home/screens/home_screen.dart';
import 'package:silver_heart/presentation/intro/screens/intro_screen.dart';
import 'package:silver_heart/presentation/sign_in/screens/sign_in_screen.dart';
import 'package:silver_heart/presentation/sign_up/screens/sign_up_screen.dart';
import 'package:silver_heart/presentation/slpash_screen/splash_screen.dart';

class Routes {
  static const splash = "/";
  static const signIn = "/sign-in";
  static const signUp = "/sign-up";
  static const intro = "/intro";
  static const home = "/home";

  static Route routes(RouteSettings routeSettings) {
    print('Route name: ${routeSettings.name}');

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
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
