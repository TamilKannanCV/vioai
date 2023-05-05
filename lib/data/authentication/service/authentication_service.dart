import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthenticationService {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  AuthenticationService(this._auth, this._googleSignIn);

  Stream<bool> watchSignInStatus() async* {
    await for (User? x in _auth.userChanges()) {
      yield x != null;
    }
  }

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signInWithGoogle() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw Exception();
    }
    final authentication = await account.authentication;
    final user = await _auth.signInWithCredential(
      GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      ),
    );
    return user;
  }
}
