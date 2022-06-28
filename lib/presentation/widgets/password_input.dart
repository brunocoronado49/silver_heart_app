import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput(
      this._passwordCtrl,
      this._showPassword,
      this._togglePassword
      );

  final TextEditingController _passwordCtrl;
  final bool _showPassword;
  final VoidCallback _togglePassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autocorrect: false,
        obscureText: !_showPassword,
        controller: _passwordCtrl,
        decoration: InputDecoration(
          labelText: 'Contraseña',
          prefixIcon: const Icon(Icons.lock_rounded),
          suffixIcon: IconButton(
            onPressed: _togglePassword,
            icon: _showPassword
                ? const Icon(Icons.visibility_off_rounded)
                : const Icon(Icons.visibility_rounded),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
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
