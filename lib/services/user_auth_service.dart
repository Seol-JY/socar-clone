import 'package:firebase_auth/firebase_auth.dart';
import 'package:socar/services/sms_send.dart';
import 'dart:math';

class UserAuthenticateService {
  static String? _currentCode;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendVerifyCode(String phoneNumber) async {
    UserAuthenticateService._currentCode = _createNewCode();
    SmsSendService.sendMessage(
        "[쏘카] 회원가입을 위한 인증 코드는 $_currentCode 입니다.", phoneNumber);
  }

  bool isAuthenticateSucceed(String code) {
    return code == UserAuthenticateService._currentCode;
  }

  Future<bool> doRegister(String emailAddress, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
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

  Future<bool> doLogin(String emailAddress, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      } else if (e.code == 'wrong-password') {
        return false;
      }
    }

    return true;
  }

  String _createNewCode() {
    Random random = Random();
    String code = random.nextInt(1000000).toString().padLeft(6, "0");

    return code;
  }
}
