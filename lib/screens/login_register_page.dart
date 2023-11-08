import 'package:flutter/material.dart';

class LoginRegisterSelectionpage extends StatelessWidget {
  const LoginRegisterSelectionpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Column(
            children: [
              Center(
                child: Text(
                  "일상의 이동부터,",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "여행까지, 쏘카에서",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(left: 2, right: 2, bottom: 1),
            child: Image.asset('assets/START_PAGE_IMG.png',
                width: double.maxFinite, height: 300, fit: BoxFit.fitWidth),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Row(children: <Widget>[
            Expanded(
              child: StartPageButton(
                buttonBackgorundColor: 0xff374553,
                text: "로그인",
                onPressed: () => Navigator.pushNamed(context, "/login"),
              ),
            ),
            Expanded(
              child: StartPageButton(
                buttonBackgorundColor: 0xff00b8ff,
                text: "회원가입",
                onPressed: () => Navigator.pushNamed(context, "/register/auth"),
              ),
            ),
          ])
        ],
      ),
    );
  }
}

class StartPageButton extends StatelessWidget {
  int buttonBackgorundColor;
  String text;

  void Function()? onPressed;

  StartPageButton({
    super.key,
    required this.buttonBackgorundColor,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return Color(buttonBackgorundColor);
        }),
      ),
      onPressed: onPressed,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          )),
    );
  }
}
