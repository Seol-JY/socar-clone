import 'package:firebase_auth/firebase_auth.dart';

class UserAuthenticateService {
  void sendVerifyCode() {}

  bool isAuthenticateSucceed() {
    return true;
  }

  Future<bool> doRegister(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return false;
      } else if (e.code == 'email-already-in-use') {
        return false;
      }
    } catch (e) {
      return false;
    }

    return true;
  }

  bool doLogin() {
    return true;
  }
}
