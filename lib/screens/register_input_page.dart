import 'package:flutter/material.dart';
import 'package:socar/widgets/app_bar.dart';
import 'package:socar/widgets/register_page/title_textform.dart';

class RegisterInputPage extends StatefulWidget {
  String username;

  RegisterInputPage({super.key, required this.username});

  @override
  State<StatefulWidget> createState() {
    return _RegisterInputState();
  }
}

class _RegisterInputState extends State<RegisterInputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "기본정보",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(
                widget.username,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xff02b8ff),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                " 님,",
                style: TextStyle(
                  fontSize: 15,
                ),
              )
            ]),
            const Text(
              "쏘카 이용을 위한 기본 정보를 입력해 주세요.",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TitleTextFormWidget(
              title: "아이디",
              hintText: "이메일 주소 입력",
            ),
            TitleTextFormWidget(
              title: "비밀번호",
              hintText: "영문, 숫자 포함 8자리 이상 입력",
              obSecure: true,
            ),
            TitleTextFormWidget(
              title: "비밀번호 확인",
              hintText: "비밀번호 재입력",
              obSecure: true,
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Material(
        color: isInputCompleted()
            ? const Color(0xff00b8ff)
            : const Color(0xffe9ebee),
        child: InkWell(
          onTap: isInputCompleted()
              ? () {
                  print("OK");
                }
              : null,
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                '입력 완료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isInputCompleted()
                      ? Colors.white
                      : const Color(0xffc5c8ce),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isInputCompleted() {
    return true;
  }
}
