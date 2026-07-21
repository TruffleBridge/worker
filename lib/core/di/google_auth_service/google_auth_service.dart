import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService();

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    await _googleSignIn.initialize();

    _initialized = true;
  }

  Future<String?> signIn() async {
    await initialize();

    try {
      final GoogleSignInAccount account =
      await _googleSignIn.authenticate();

      final GoogleSignInAuthentication auth =
          account.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      return auth.idToken;
    } on GoogleSignInException catch (e) {
      print("Google Sign-In Error: ${e.code}");
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    await _googleSignIn.signOut();
  }
}