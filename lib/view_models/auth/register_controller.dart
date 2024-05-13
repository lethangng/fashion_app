import '../../services/auth_service.dart';

class RegisterController {
  Future<void> authenticationWithGoogle() async {
    try {
      await AuthService.signInWithGoogle();
    } catch (e) {
      return;
    }
  }

  Future<void> authenticationWithFacebook() async {
    try {
      await AuthService.signInWithFacebook();
    } catch (e) {
      return;
    }
  }
}
