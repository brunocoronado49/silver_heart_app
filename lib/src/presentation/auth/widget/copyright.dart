import 'package:flutter/material.dart';

class Copyright extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 80),
      child: Text(
        "Todos los derechos reservados.",
        style: TextStyle(
          fontSize: 9
        ),
      ),
    );
  }
}