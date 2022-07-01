import 'package:flutter/material.dart';

class ProfileInputInfo extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProfileInputInfo(
      this._profileInputCtrl, this._inputLabel, this._iconInput);

  final TextEditingController _profileInputCtrl;
  final String _inputLabel;
  final Icon _iconInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: _profileInputCtrl,
      minLines: 1,
      maxLines: 8,
      decoration: InputDecoration(
        labelText: _inputLabel,
        prefixIcon: _iconInput,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value.toString().isEmpty) {
          return "No dejes el espacio vacío.";
        }
        return null;
      },
    );
  }
}
