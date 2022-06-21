import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/presentation/sign_in/widgets/login_image.dart';
import 'package:silver_heart/presentation/sign_in/widgets/sign_up_button.dart';
import 'package:silver_heart/presentation/widgets/email_input.dart';
import 'package:silver_heart/presentation/widgets/password_input.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static Widget create(BuildContext context) => const SignInScreen();

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _showPassword = false;

  String? validator(String? value) {
    return (value == null || value.isEmpty)
        ? "Completa los campos porfavor."
        : null;
  }

  _togglePassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicia sesión"),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (_, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is AuthStateSigninIn)
                    const Center(child: CircularProgressIndicator()),
                  if (state is AuthStateError)
                    Text(
                      state.error,
                      style: const TextStyle(
                          color: Colors.redAccent, fontSize: 24),
                    ),
                  const SizedBox(height: 8),
                  const LoginImage(),
                  EmailInput(_emailCtrl),
                  const SizedBox(height: 8),
                  PasswordInput(_passwordCtrl, _showPassword, _togglePassword),
                  const SizedBox(height: 8),
                  Center(
                    child: ElevatedButton(
                      child: const Text("Inicia sesión"),
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          context.read<AuthCubit>().signInWithEmailAndPassword(
                              _emailCtrl.text.trim(),
                              _passwordCtrl.text.trim());
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SignUpButton()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
