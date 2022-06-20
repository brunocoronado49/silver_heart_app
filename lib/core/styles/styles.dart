import 'package:flutter/material.dart';
import 'app-colors.dart';

class Styles {
  ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0x2980b9),
    scaffoldBackgroundColor: AppColors.background,
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textTheme: ButtonTextTheme.primary,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
  );
}

final Styles styles = Styles();