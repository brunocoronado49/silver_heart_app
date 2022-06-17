import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../login/widgets/forgot_password.dart';
import '../../login/widgets/sign_in_text.dart';
import '../../login/widgets/sign_up_button.dart';
import '../../widgets/copyright.dart';
import '../../widgets/logo.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _showPassword = false;
  late FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    auth;
  }

  void _togglePassword() {
    setState(() => _showPassword = !_showPassword);
  }

  Future<void> login() async {
    await auth.signInWithEmailAndPassword(email: _email.text.trim(), password: _password.text.trim());
    print("Logged");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email_rounded),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 0.5,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
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
                    obscureText: _showPassword,
                    controller: _password,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_rounded),
                      hintText: 'Contraseña',
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
                ForgotPAssword(),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: ElevatedButton(
                    onPressed: login,
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
      ),
    );
  }
}
