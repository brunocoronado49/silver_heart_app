import 'package:flutter/material.dart';
import 'package:silver_heart/presentation/intro/widgets/on_boarding_page.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => IntroScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Silver Heart"),
      ),
      body: const OnBoardingPage(),
    );
  }
}