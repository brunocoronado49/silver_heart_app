import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/presentation/sign_up/widgets/confirm_password_input.dart';
import 'package:silver_heart/presentation/sign_up/widgets/sign_up_image.dart';
import 'package:silver_heart/presentation/widgets/email_input.dart';
import 'package:silver_heart/presentation/widgets/password_input.dart';
import 'package:silver_heart/repository/implementations/auth_repository_implement.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static Widget create(BuildContext context) => const SignUpScreen();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  final _authCubit = AuthCubit(AuthRepository());
  bool _showPassword = false;
  late String _password = "";

  @override
  void initState() {
    _authCubit.init();
    _passwordCtrl.addListener(() {
      setState(() => _password = _passwordCtrl.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    _authCubit.close();
    super.dispose();
  }

// Funcion de validación de correo
  String? emailValidator(String? value) {
    return (value == null || value.isEmpty)
        ? "Completa los campos por favor."
        : null;
  }

// Función de validacion de contraseña
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return "Completa los campos por favor";
    if (value.length < 6) return "La contraseña es muy corta";
    if (_passwordCtrl.text != _confirmPasswordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

// Muestra o oculta la contraseña
  void _togglePassword() {
    setState(() => _showPassword = !_showPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Crea una cuenta",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (_, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                  const SignUpImage(),
                  EmailInput(_emailCtrl),
                  const SizedBox(height: 8),
                  PasswordInput(_passwordCtrl, _showPassword, _togglePassword),
                  const SizedBox(height: 8),
                  ConfirmPasswordInput(
                    _confirmPasswordCtrl,
                    _showPassword,
                    _password
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          context
                          .read<AuthCubit>()
                          .createUserWithEmailAndPassword(
                            _emailCtrl.text.trim(),
                            _passwordCtrl.text.trim()
                          );
                        }
                      },
                      label: const Text("Crea una cuenta"),
                      icon: const Icon(Icons.account_box),
                      backgroundColor: Colors.amber,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
