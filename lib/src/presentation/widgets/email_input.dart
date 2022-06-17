import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  const EmailInput(this._emailCtrl, this._emailNode);

  final TextEditingController _emailCtrl;
  final FocusNode _emailNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        controller: _emailCtrl,
        focusNode: _emailNode,
        minLines: 1,
        maxLines: 2,
        style: const TextStyle(
          fontWeight: FontWeight.w600
        ),
        decoration: const InputDecoration(
          labelText: 'Correo',
          prefixIcon: Icon(Icons.alternate_email_rounded),
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
        validator: (value) {
          if (value.toString().isEmpty) {
            return "Introduce un correo válido.";
          }
          return null;
        },
      ),
    );
  }
}
