import 'package:firebase_auth/firebase_auth.dart';

class UserAuthenticateService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendVerifyCode() async {
    await _auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
      phoneNumber: "+8210" +
          phoneNumberController1.text.trim() +
          phoneNumberController2.text.trim(),
      verificationCompleted: (phoneAuthCredential) async {
        print("otp 문자옴");
      },
      verificationFailed: (verificationFailed) async {
        print(verificationFailed.code);

        print("코드발송실패");
        setState(() {
          showLoading = false;
        });
      },
      codeSent: (verificationId, resendingToken) async {
        print("코드보냄");
        Fluttertoast.showToast(
            msg:
                "010-${phoneNumberController1.text}-${phoneNumberController2.text} 로 인증코드를 발송하였습니다. 문자가 올때까지 잠시만 기다려 주세요.",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            fontSize: 12.0);
        setState(() {
          requestedAuth = true;
          FocusScope.of(context).requestFocus(otpFocusNode);
          showLoading = false;
          this.verificationId = verificationId;
        });
      },
    );
  }

  bool isAuthenticateSucceed() {
    return true;
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
