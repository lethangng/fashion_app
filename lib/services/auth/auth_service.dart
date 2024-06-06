import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthException implements Exception {
  final int code;
  final String message;

  AuthException({
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}

class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;
  static User? get user => _auth.currentUser;

  static Future<UserCredential> loginWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (_) {
      throw AuthException(
        code: 1,
        message: 'Email hoặc mật khẩu không đúng.',
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user?.sendEmailVerification();
      credential.user?.updateDisplayName(fullName);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(
          code: 2,
          message: 'Mật khẩu quá yếu.',
        );
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(
          code: 3,
          message: 'Email đã tồn tại.',
        );
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> resetPassword({required String email}) =>
      _auth.sendPasswordResetEmail(email: email);

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['email'],
    );

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return _auth.signInWithCredential(facebookAuthCredential);
  }

  static Future<void> logout() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
