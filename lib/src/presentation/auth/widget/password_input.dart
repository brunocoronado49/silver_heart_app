import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput(
      this._passwordCtrl,
      this._passwordFocus,
      this._showPassword,
      this._togglePassword
      );

  final TextEditingController _passwordCtrl;
  final FocusNode _passwordFocus;
  final bool _showPassword;
  final Function _togglePassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autocorrect: false,
        obscureText: !_showPassword,
        controller: _passwordCtrl,
        focusNode: _passwordFocus,
        style: const TextStyle(
          fontWeight: FontWeight.w600
        ),
        decoration: InputDecoration(
          labelText: "Password",
          prefixIcon: const Icon(Icons.lock_rounded),
          suffixIcon: IconButton(
              onPressed: _togglePassword(),
              icon: _showPassword
                  ? const Icon(Icons.visibility_off_rounded)
                  : const Icon(Icons.visibility_rounded),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
            color: Colors.grey,
                width: 0.5
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue,
                width: 0.5
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blueAccent
            ),
          ),
        ),
        validator: (value) {
          if(value.toString().isEmpty) {
            return "Ingresa una contraseña";
          }
          return null;
        },
      ),
    );
  }
}
