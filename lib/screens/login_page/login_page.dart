import 'package:flutter/material.dart';
import 'package:socar/services/user_auth_service.dart';
import 'package:socar/widgets/app_bar.dart';
import 'package:socar/utils/user_input_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _pwController = TextEditingController();
  final UserAuthenticateService authenticateService = UserAuthenticateService();
  bool isEnabled() {
    final String email = _emailController.text;
    final String password = _pwController.text;
    return UserInputValidator.validEmailFormat(email) &&
        UserInputValidator.validPasswordFormat(password);
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
    _pwController.addListener(() {
      setState(() {});
    });
  }

  void doAuthenticate() {
    authenticateService
        .doLogin(_emailController.text, _pwController.text)
        .then((value) => {Navigator.pushNamed(context, '/main')});
  }

  @override
  Widget build(BuildContext context) {
    // ------------ Style 정의 ------------
    TextStyle titleStyle = const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
    );

    InputDecoration idInputField = const InputDecoration(
      hintText: "가입한 이메일 주소 입력",
      hintStyle: TextStyle(
        color: Color(0xffc5c5c7),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffe9ebee), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff00b8ff), width: 2.0),
      ),
    );

    InputDecoration pwInputField = const InputDecoration(
      hintText: "비밀번호 입력",
      hintStyle: TextStyle(
        color: Color(0xffc5c5c7),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffe9ebee),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff00b8ff),
          width: 2.0,
        ),
      ),
    );

    ButtonStyle loginButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          // 두 상태가 모두 true일 때
          if (isEnabled()) {
            return const Color(0xff00b8ff);
          }
          // 기타 상황 (예: 버튼이 비활성화 상태일 때)
          return const Color(0xffe9ebee);
        },
      ),
      elevation: MaterialStateProperty.all(0),
    );

    TextStyle loginButtonTextStyle = TextStyle(
      color: isEnabled()
          ? Colors.white
          : Colors.grey, // isEnabled 상태에 따른 텍스트 색상 설정
    );

    // ------------ Layout 정의 ------------
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "로그인",
              style: titleStyle,
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _emailController,
              decoration: idInputField,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: pwInputField,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: doAuthenticate,
              style: loginButtonStyle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '로그인하기',
                  style: loginButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
