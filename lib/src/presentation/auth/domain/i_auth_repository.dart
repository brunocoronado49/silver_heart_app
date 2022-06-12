import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/errors/failures.dart';

abstract class IAuthRepository {

  // get current firebase user signed in
  Future<Either<Failure, User>> getSignedUser();

  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  // sign up a new user
  Future<Either<Failure, Unit>> signUpWithEmailAndPassword({
    required String email,
    required String password
  });

  // for change the password
  Future<Either<Failure, Unit>> resetPAssword(String email);

  Future<void> signOut();
}