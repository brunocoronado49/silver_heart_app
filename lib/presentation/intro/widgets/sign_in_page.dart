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
      child: Column(
        children: [
          Image.asset(
            "assets/papper.png",
            width: 200,
            height: 200,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Inicia sesión o crea una cuenta nueva",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (isSigninIn) const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                const SizedBox(height: 8),
                SignInButton(
                  text: "Inicia con Google",
                  imagePath: "assets/google-icon.png",
                  color: Colors.white,
                  textColor: Colors.grey,
                  onTap: () => authCubit.signInWithGoogle(),
                ),
                const SizedBox(height: 8),
                SignInButton(
                  text: "Inicia con correo y contraseña",
                  imagePath: "assets/login.png",
                  color: Colors.red,
                  textColor: Colors.white,
                  onTap: () {
                    authCubit.reset();
                    Navigator.pushNamed(context, Routes.signIn);
                  },
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  child: const Text("Crea una cuenta nueva"),
                  onPressed: () {
                    authCubit.reset();
                    Navigator.pushNamed(context, Routes.signUp);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}