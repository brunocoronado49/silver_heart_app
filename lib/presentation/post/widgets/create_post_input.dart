import 'package:flutter/material.dart';

class CreatePostInput extends StatelessWidget {
  const CreatePostInput(
    this._createPostInputCtrl,
    this._inputLabel,
  );

  final TextEditingController _createPostInputCtrl;
  final String _inputLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        autocorrect: false,
        controller: _createPostInputCtrl,
        minLines: 1,
        maxLines: 8,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: _inputLabel,
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