import 'package:flutter/material.dart';
import 'package:socar/widgets/app_bar.dart';
import 'package:socar/widgets/register_page/title_textform.dart';

class RegisterInputPage extends StatefulWidget {
  const RegisterInputPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterInputState();
  }
}

class _RegisterInputState extends State<RegisterInputPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwValidController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      setState(() {});
    });
    pwController.addListener(() {
      setState(() {});
    });

    pwValidController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as InputPageArguments;

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
                args.username,
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
              controller: emailController,
            ),
            TitleTextFormWidget(
              title: "비밀번호",
              hintText: "영문, 숫자 포함 8자리 이상 입력",
              obSecure: true,
              controller: pwController,
            ),
            TitleTextFormWidget(
              title: "비밀번호 확인",
              hintText: "비밀번호 재입력",
              obSecure: true,
              controller: pwValidController,
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
                  bool registerSuccess = doRegister();

                  if (registerSuccess) {
                    showSuccessModal();
                  }
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
    return validEmail() && validPassword();
  }

  bool validEmail() {
    // 이메일 형식을 검증하기 위한 정규 표현식
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    // 정규 표현식과 문자열을 비교하여 형식이 일치하는지 확인
    bool validEmail = emailRegExp.hasMatch(emailController.text);

    if (!validEmail) {
      return false;
    }
    // 이메일 중복 체크 로직 필요

    return true;
  }

  bool validPassword() {
    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$');

    // 정규 표현식과 문자열을 비교하여 형식이 일치하는지 확인
    return passwordRegExp.hasMatch(pwController.text) &&
        (pwController.text == pwValidController.text);
  }

  bool doRegister() {
    return true;
  }

  void showSuccessModal() {
    DateTime today = DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 350,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "🎉",
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "쏘카 가입을 환영합니다!",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text("쏘카의 다양한 서비스를 지금 바로 이용해보세요."),
                      const Text(
                        "-",
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xffc5c8ce),
                        ),
                      ),
                      const Text(
                        "(주)쏘카",
                        style: TextStyle(
                          color: Color(0xff6f7985),
                        ),
                      ),
                      Text(
                        "회원님이 ${today.year}년 ${today.month}월 ${today.day}일에 요청하신 마케팅 정보 수신동의는 문자메시지, 이메일, 푸시메시지 쿠폰/혜택 알림 미동의 처리되었습니다.",
                        style: const TextStyle(
                          color: Color(0xff6f7985),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffe9ebee),
                    ),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "서비스 둘러보기",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff00b8ff),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class InputPageArguments {
  final String username;

  InputPageArguments({required this.username});
}
