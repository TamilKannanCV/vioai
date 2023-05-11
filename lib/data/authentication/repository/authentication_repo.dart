import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthenticationRepo {
  Stream<bool> watchUserAuthChanges();
  Future<Either<dynamic, UserCredential>> signInWithGoogle();
  User? get currentUser;
}
