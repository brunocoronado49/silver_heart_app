import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Colors.white;
  static const secondaryColor = Colors.grey;
  static const thirdColor = Colors.black;
  static const elevation = 0;

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: thirdColor,
        fontSize: 20,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Quicksand',
  );
}