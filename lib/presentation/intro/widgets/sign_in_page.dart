import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/bloc/auth_bloc/auth_bloc.dart';
import 'package:silver_heart/presentation/intro/widgets/sign_in_button.dart';
import 'package:silver_heart/routes/routes.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final isSigninIn = authCubit.state is AuthStateSigninIn;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white38,
            Colors.grey,
          ]
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 150),
            alignment: Alignment.topCenter,
            child: const Text(
              "Inicia sesión o crea una cuenta nueva",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          if (isSigninIn) const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(height: 50),
                SignInButton(
                  text: "Crea una cuenta",
                  imagePath: "assets/edit.png",
                  onTap: () {
                    authCubit.reset();
                    Navigator.pushNamed(context, Routes.signUp);
                  },
                ),
                const SizedBox(height: 10),
                SignInButton(
                  text: "Inicia sesión",
                  imagePath: "assets/user.png",
                  onTap: () {
                    authCubit.reset();
                    Navigator.pushNamed(context, Routes.signIn);
                  },
                ),
                const SizedBox(height: 10),
                SignInButton(
                  text: "Inicia con Google",
                  imagePath: "assets/google-login-icon.png",
                  onTap: () => authCubit.signInWithGoogle(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
