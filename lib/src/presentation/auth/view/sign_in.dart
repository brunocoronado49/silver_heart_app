import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/src/presentation/auth/bloc/sign_in/sign_in_event.dart';
import 'package:silver_heart/src/presentation/auth/bloc/sign_in/sign_in_state.dart';
import '../bloc/sign_in/sign_in_bloc.dart';
import '../widget/sign_in/forgot_password.dart';
import '../widget/sign_in/sign_in_text.dart';
import '../widget/sign_in/sign_up_button.dart';
import '../widget/copyright.dart';
import '../widget/logo.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _showPassword = false;
  final SignInBloc _bloc = SignInBloc();

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _togglePassword() {
    setState(() => _showPassword = !_showPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignInBloc, SignInState>(
        bloc: _bloc,
        builder: (context, state) {
          return ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                margin:  const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 250,
                          child: Logo(),
                        ),
                      ),
                    ),
                    SignInText(),
                    if (state.result.containsKey('error-general')) Text(
                      state.result['error-general'],
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        enabled: state.state == SignInStateValue.DONE,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.alternate_email_rounded),
                          labelText: "Email",
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          errorText: state.result.containsKey('error-email')
                              ? state.result['error-email'] : null,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                              width: 0.5,
                            ),
                          ),
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        keyboardType: TextInputType.visiblePassword,
                        enabled: state.state == SignInStateValue.DONE,
                        obscureText: _showPassword,
                        controller: _password,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_rounded),
                          hintText: 'Contraseña',
                          errorText: state.result.containsKey('error-password')
                              ? state.result['error-password'] : null,
                          suffixIcon: IconButton(
                            onPressed: _togglePassword,
                            icon: _showPassword ?
                              const Icon(Icons.visibility_off) :
                              const Icon(Icons.visibility),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                              width: 0.5,
                            ),
                          ),
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (state.state == SignInStateValue.IN_PROGRESS)
                      const LinearProgressIndicator(),
                    ForgotPAssword(),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: ElevatedButton(
                        onPressed: state.state == SignInStateValue.IN_PROGRESS ? null : () {
                          _bloc.add(ClickSignInEvent(
                            _email.text.trim(),
                            _password.text.trim(),
                          ));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Iniciar sesión",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SignUpButton(),
                    Copyright(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
