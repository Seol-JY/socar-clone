import 'package:flutter/material.dart';
import 'package:socar/widgets/app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();
  bool isEnabled = false; // 초기값

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        isEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            const Text(
              "로그인",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
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
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 실행할 로직을 여기에 작성
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    // 두 상태가 모두 true일 때
                    if (isEnabled) {
                      return const Color(0xff00b8ff);
                    }
                    // 기타 상황 (예: 버튼이 비활성화 상태일 때)
                    return const Color(0xffe9ebee);
                  },
                ),
                elevation: MaterialStateProperty.all(0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '로그인하기',
                  style: TextStyle(
                    color: isEnabled
                        ? Colors.white
                        : Colors.grey, // isEnabled 상태에 따른 텍스트 색상 설정
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
