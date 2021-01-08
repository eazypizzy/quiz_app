import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _fAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth fAuth, GoogleSignIn googleSignIn})
      : _fAuth = fAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _fAuth.signInWithCredential(credential);

    return _fAuth.currentUser;
  }

  Future<void> signInWithCredentials(String email, String password) async {
    return await _fAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp(String email, String password) async {
    return await _fAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _googleSignIn.signOut(),
      _fAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final cUser = _fAuth.currentUser;

    return cUser != null;
  }

  Future<String> getUser() async {
    return (_fAuth.currentUser).email;
  }
}
