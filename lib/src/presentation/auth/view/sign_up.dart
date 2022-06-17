import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:silver_heart/src/presentation/auth/widget/sign_up/sign_in_button.dart';
import 'package:silver_heart/src/presentation/auth/widget/sign_up/sign_up_text.dart';
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
  bool _inProgress = false;
  bool _showPassword = false;
  String prefix = "";
  late FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    auth;
  }

  void _togglePassword() {
    setState(() => _showPassword = !_showPassword);
  }

  Future<void> createAccount() async {
    await auth.createUserWithEmailAndPassword(email: _email.text.trim(), password: _password.text.trim());
    print("account created");
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
                      child: SignLogo(),
                    ),
                  ),
                ),
                SignUpText(),
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
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _showPassword,
                    controller: _confirmPassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_rounded),
                      hintText: 'Confirmar contraseña',
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
                    onPressed: () async {
                      if (_email.text.trim().isNotEmpty ||
                          _password.text.trim().isNotEmpty ||
                          _confirmPassword.text.trim().isNotEmpty) {
                        createAccount();
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
      ),
    );
  }
}
