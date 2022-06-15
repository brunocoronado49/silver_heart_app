import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/src/presentation/auth/bloc/sign_up/sign_up_event.dart';
import 'package:silver_heart/src/presentation/auth/bloc/sign_up/sign_up_state.dart';
import 'package:silver_heart/src/presentation/auth/widget/sign_up/sign_in_button.dart';
import 'package:silver_heart/src/presentation/auth/widget/sign_up/sign_up_text.dart';
import '../bloc/sign_up/sign_up_bloc.dart';
import '../widget/copyright.dart';
import '../widget/sign_up/sign_logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final SignUpBloc _bloc = SignUpBloc();
  bool _inProgress = false;
  bool _showPassword = false;
  String prefix = "";

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
      body: BlocBuilder<SignUpBloc, SignUpState>(
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
                          child: SignLogo(),
                        ),
                      ),
                    ),
                    SignUpText(),
                    if (state.result.containsKey('error-general')) Text(
                      state.result['error-general'],
                      style: const TextStyle(color: Colors.red),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        enabled: state.state == SignUpStateValue.DONE,
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
                        enabled: state.state == SignUpStateValue.DONE,
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
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        keyboardType: TextInputType.visiblePassword,
                        enabled: state.state == SignUpStateValue.DONE,
                        obscureText: _showPassword,
                        controller: _password,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_rounded),
                          hintText: 'Confirmar contraseña',
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
                    if(_inProgress) const LinearProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_email.text.trim().isNotEmpty ||
                              _password.text.trim().isNotEmpty ||
                              _confirmPassword.text.trim().isNotEmpty) {
                            _bloc.add(ClickSignUpEvent(
                                _email.text.trim(),
                                _password.text.trim(),
                                _confirmPassword.text.trim()
                            ));
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Regístrate",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SignInButton(),
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
