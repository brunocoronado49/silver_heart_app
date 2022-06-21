import 'package:flutter/material.dart';

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput(this._confirmPasswordCtrl, this.validator, this._showPassword);

  final TextEditingController _confirmPasswordCtrl;
  final Function validator;
  final bool _showPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autocorrect: false,
        obscureText: _showPassword,
        keyboardType: TextInputType.visiblePassword,
        controller: _confirmPasswordCtrl,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "Confirma tu contraseña",
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 0.5,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 0.5,
            ),
          ),
        ),
        validator: validator(),
      ),
    );
  }
}
