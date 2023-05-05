import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepo {
  Stream<bool> watchUserAuthChanges();
  Future<Either<dynamic, UserCredential>> signInWithGoogle();
}
