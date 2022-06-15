import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static Flushbar successSnackBar(
      String message, {
        FlushbarPosition position = FlushbarPosition.BOTTOM
      }
      ) {
    return Flushbar(
      backgroundColor: Colors.grey,
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.greenAccent,
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
      ),
      shouldIconPulse: false,
      duration: const Duration(seconds: 5),
      flushbarPosition: position,
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
    );
  }

  static Flushbar failSnackBar(
      String message, {
        FlushbarPosition position = FlushbarPosition.BOTTOM
      }
      ) {
    return Flushbar(
      backgroundColor: Colors.grey,
      icon: const Icon(
        Icons.dangerous_outlined,
        color: Colors.greenAccent,
      ),
      title: 'Ocurrió un error',
      messageText: Text(
        message,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
      ),
      shouldIconPulse: false,
      duration: const Duration(seconds: 5),
      flushbarPosition: position,
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
    );
  }
}
