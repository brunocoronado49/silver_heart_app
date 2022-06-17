import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'sign_up_state.dart';
import 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(): super(SignUpInitialState(resultInitial, SignUpStateValue.DONE)) {
    on<SignUpEvent>((event, emit) async {
      late FirebaseAuth auth;
      auth = FirebaseAuth.instance;

      if(event is ClickSignUpEvent) {
        String email = event.email;
        String password = event.password;
        String confirmPassword = event.confirmPassword;
        bool complete = false;
        Map<String, dynamic> result = {};

        if (email.isEmpty) {
          result['error-email'] = 'No puedes dejar este campo vacío';
        }
        if (password.isEmpty) {
          result['error-password'] = 'No puedes dejar este campo vacío';
        }
        if (confirmPassword.isEmpty) {
          result['error-confirm'] = 'No puedes dejar este campo vacío';
        }
        if (password.length < 8) {
          result['error-password'] = 'Debe contener mínimo 8 caracteres';
        }
        if (confirmPassword.length < 8) {
          result['error-confirm'] = 'Debe contener mínimo 8 caracteres';
        }
        if (confirmPassword != password) {
          result['error-confirm'] = 'Las contraseñas no coinciden';
        }

        SignUpState(result, SignUpStateValue.IN_PROGRESS);
        try {
          await auth.createUserWithEmailAndPassword(email: email, password: password);
          complete = true;
        } on PlatformException catch (error) {
          switch(error.code) {
            case "ERROR_INVALID_EMAIL":
              result['error-email'] = "Email inválido.";
              break;
            case "ERROR_WEAK_PASSWORD":
              result['error-password'] = "Contraseña inválida, es muy débil.";
              break;
            case "ERROR_EMAIL_ALREADY_IN_USE":
              result['error-email'] = "Email en uso, prueba con otro.";
              break;
            default: result['error-general'] = 'Error inesperado: ${error.message}';
            break;
          }
        }
        SignUpState(result, SignUpStateValue.DONE, registrationComplete: complete);
      } else {
        const SignUpState({}, SignUpStateValue.DONE);
      }
    });
  }
  static Map<String, dynamic> get resultInitial => {};
}