import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  const EmailInput(this._emailCtrl, this._emailFocus);

  final TextEditingController _emailCtrl;
  final FocusNode _emailFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        controller: _emailCtrl,
        focusNode: _emailFocus,
        minLines: 1,
        maxLines: 2,
        style: const TextStyle(
          fontWeight: FontWeight.w600
        ),
        decoration: const InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500
          ),
          prefixIcon: Icon(Icons.alternate_email_rounded),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 0.5
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent
            ),
          ),
        ),
        validator: (value) {
          if(value.toString().isEmpty) {
            return "Ingresa un correo por favor";
          }
          return null;
        },
      ),
    );
  }
}