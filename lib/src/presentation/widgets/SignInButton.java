package src.presentation.widgets;

import 'package:flutter/material.dart';
import 'package:tapp/core/themes/app_colors.dart';

class SignInButton extends StatelessWidget {
  final Function _signInFunction;

  const SignInButton(this._signInFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColors.purple,
        child: Text(
          'Entrar',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: _signInFunction,
      ),
    );
  }
}
