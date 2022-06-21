import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static Widget create(BuildContext context) => const SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/cat-sleep.png",
              key: const Key("splash_image"),
              width: 150
            ),
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            const Text('Cargando...', style: TextStyle(fontSize: 24))
          ],
        ),
      ),
    );
  }
}
