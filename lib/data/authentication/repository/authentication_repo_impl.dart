import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/authentication/repository/authentication_repo.dart';
import 'package:vioai/data/authentication/service/authentication_service.dart';
import 'package:vioai/logger.dart';

@Injectable(as: AuthenticationRepo)
class AuthenticationRepoImpl implements AuthenticationRepo {
  final AuthenticationService _service;
  AuthenticationRepoImpl(this._service);

  @override
  Stream<bool> watchUserAuthChanges() {
    return _service.watchSignInStatus();
  }

  @override
  Future<Either<dynamic, UserCredential>> signInWithGoogle() async {
    try {
      final response = await _service.signInWithGoogle();
      return Right(response);
    } catch (e) {
      logger.e(e);
      return Left(e);
    }
  }
}
