import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'sign_in_state.dart';
import 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState(resultInitial, SignInStateValue.DONE)) {
    on<SignInEvent>((event, emit) async {
      late FirebaseAuth auth;
      auth = FirebaseAuth.instance;

      if(event is ClickSignInEvent) {
        String email = event.email;
        String password = event.password;
        Map<String, dynamic> result = {};

        if (email.isEmpty) {
          result['error-email'] = 'Por favor ingresa un correo.';
        }
        if (password.isEmpty) {
          result['error-password'] = 'Por favor ingresa contraseña.';
        }
        if (password.length < 8) {
          result['error-password'] = 'La contraseña debe contener minimo 8 caratcteres';
        }

        SignInState(result, SignInStateValue.IN_PROGRESS);
        try {
          await auth.signInWithEmailAndPassword(email: email, password: password);
        } on PlatformException catch (error) {
          switch (error.code) {
            case "ERROR_INVALID_EMAIL":
              result['error-email'] = "Correo invalido.";
              break;
            case "ERROR_WRONG_PASSWORD":
              result['error-password'] = "Password invalida.";
              break;
            case "ERROR_USER_NOT_FOUND":
              result['error-email'] = "Usuario no encontrado.";
              break;
            case "ERROR_USER_DISABLED":
              result['error-email'] = "Usuario dehabilitado.";
              break;
            case "ERROR_TOO_MANY_REQUESTS":
              result['error-email'] = "Demasiadas peticiones, prueba despues.";
              break;
            case 'ERROR_OPERATION_NOT_ALLOWED':
              result['error-general'] = 'Operacion no permitida';
              break;
            default: result['error-general'] = 'Error inesperado: ${error.message}';
            break;
          }
        }
        SignInState(result, SignInStateValue.DONE);
      } else {
        const SignInState({}, SignInStateValue.DONE);
      }
    });
  }
  static Map<String, dynamic> get resultInitial => {};
}