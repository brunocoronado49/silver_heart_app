import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput(
      this._passwordCtrl,
      this._passwordNode,
      this._showPassword,
      this._togglePasswordText
      );

  final TextEditingController _passwordCtrl;
  final FocusNode _passwordNode;
  final bool _showPassword;
  final Function _togglePasswordText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autocorrect: false,
        obscureText: !_showPassword,
        controller: _passwordCtrl,
        focusNode: _passwordNode,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: 'Contraseña',
          prefixIcon: const Icon(Icons.lock_rounded),
          suffixIcon: IconButton(
            onPressed: _togglePasswordText(),
            icon: _showPassword
                ? const Icon(Icons.visibility_off_rounded)
                : const Icon(Icons.visibility_rounded),
          ),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 0.5,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 0.5,
            ),
          ),
        ),
        validator: (value) {
          if (value.toString().isEmpty) {
            return "La contraseña no puede estar vacía.";
          }
          return null;
        },
      ),
    );
  }
}
