import 'package:firebase_auth/firebase_auth.dart';

class UserAuthenticateService {
  bool authOk = false;
  static String? verificationId;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendVerifyCode(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
      phoneNumber: "+82$phoneNumber",
      verificationCompleted: (phoneAuthCredential) async {},
      verificationFailed: (verificationFailed) async {},
      codeSent: (verificationId, resendingToken) async {
        UserAuthenticateService.verificationId = verificationId;
      },
    );
  }

  Future<void> isAuthenticateSucceed(String code) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: UserAuthenticateService.verificationId!, smsCode: code);
    try {
      await _signInWithPhoneAuthCredential(phoneAuthCredential);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user == null) {
        throw Exception("인증 코드가 잘못되었거나 만료되었습니다.");
      }

      // 휴대폰 전화번호로 로그인 된거 로그아웃 및 유저 제거
      await _auth.currentUser!.delete();
      _auth.signOut();
    } on FirebaseAuthException {
      throw Exception("인증 코드가 잘못되었거나 만료되었습니다.");
    }
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
}
