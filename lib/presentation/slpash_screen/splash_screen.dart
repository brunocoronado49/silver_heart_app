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
          children: const [
            CircularProgressIndicator(color: Colors.black),
            SizedBox(height: 24),
            Text('Cargando...', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
