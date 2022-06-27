import 'package:flutter/material.dart';

class ProfileInputInfo extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProfileInputInfo(
    this._profileInputCtrl,
    this._inputLabel,
    this._iconInput
  );

  final TextEditingController _profileInputCtrl;
  final String _inputLabel;
  final Icon _iconInput;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        autocorrect: false,
        controller: _profileInputCtrl,
        minLines: 1,
        maxLines: 8,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: _inputLabel,
          prefixIcon: _iconInput,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
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
      ),
    );
  }
}