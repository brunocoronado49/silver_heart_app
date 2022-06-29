import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/core/helpers/snackbar_helper.dart';
import 'package:silver_heart/presentation/sign_in/widgets/login_image.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';
import 'package:silver_heart/repository/repository.dart';

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
  final _authCubit = AuthCubit(AuthRepository());
  bool _showPassword = false;

  String? validator(String? value) {
    return (value == null || value.isEmpty)
        ? "Completa los campos porfavor."
        : null;
  }

  void _togglePassword() {
    setState(() => _showPassword = !_showPassword);
  }

  @override
  void initState() {
    _authCubit.init();
    super.initState();
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Inicia sesión",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthStateError) {
            SnackBarHelper.failSnackBar(state.error).show(context);
          }

          if (state is AuthStateSingedIn) {
            SnackBarHelper.successSnackBar("Bienvenido.").show(context);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is AuthStateSigninIn)
                      const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 8),
                    const LoginImage(),
                    EmailInput(_emailCtrl),
                    const SizedBox(height: 8),
                    PasswordInput(
                        _passwordCtrl, _showPassword, _togglePassword),
                    const SizedBox(height: 8),
                    Center(
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context
                            .read<AuthCubit>()
                            .signInWithEmailAndPassword(
                              _emailCtrl.text.trim(),
                              _passwordCtrl.text.trim()
                            );
                          }
                        },
                        label: const Text("Inicia sesión"),
                        icon: const Icon(Icons.login_outlined),
                        backgroundColor: Colors.black87,
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
