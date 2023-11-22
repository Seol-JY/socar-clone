import 'package:flutter/material.dart';
import 'package:socar/screens/login_register_page/widgets/start_page_button.dart';
import 'package:socar/screens/login_register_page/widgets/title_text.dart';
import 'package:socar/screens/login_register_page/widgets/image_container.dart';

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
          const TitleTextWidget(),
          const SizedBox(
            height: 50,
          ),
          const ImageContainer(),
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
