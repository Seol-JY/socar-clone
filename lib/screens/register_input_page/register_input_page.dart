import 'package:flutter/material.dart';
import 'package:socar/models/user.dart';
import 'package:socar/services/user_auth_service.dart';
import 'package:socar/services/user_service.dart';
import 'package:socar/widgets/app_bar.dart';
import 'package:socar/screens/register_input_page/widgets/title_textform.dart';
import 'package:socar/utils/user_input_validator.dart';

class RegisterInputPage extends StatefulWidget {
  const RegisterInputPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterInputState();
  }
}

class _RegisterInputState extends State<RegisterInputPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwValidController = TextEditingController();
  final UserAuthenticateService authenticateService = UserAuthenticateService();

  final UserService userService = UserService();
  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {});
    });
    _pwController.addListener(() {
      setState(() {});
    });

    _pwValidController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as InputPageArguments;

    // style 정의
    TextStyle nameStyle = const TextStyle(
      fontSize: 15,
      color: Color(0xff02b8ff),
      fontWeight: FontWeight.bold,
    );

    TextStyle nameAfterStyle = const TextStyle(
      fontSize: 15,
    );

    Color bottomButtonColor = UserInputValidator.validEmailAndPasswordFormat(
            _emailController.text, _pwController.text)
        ? const Color(0xff00b8ff)
        : const Color(0xffe9ebee);

    TextStyle bottomButtomTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: isReadyToRegister() ? Colors.white : const Color(0xffc5c8ce),
    );

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
                style: nameStyle,
              ),
              Text(
                " 님,",
                style: nameAfterStyle,
              )
            ]),
            Text(
              "쏘카 이용을 위한 기본 정보를 입력해 주세요.",
              style: nameAfterStyle,
            ),
            TitleTextFormWidget(
              title: "아이디",
              hintText: "이메일 주소 입력",
              controller: _emailController,
            ),
            TitleTextFormWidget(
              title: "비밀번호",
              hintText: "영문, 숫자 포함 8자리 이상 입력",
              obSecure: true,
              controller: _pwController,
            ),
            TitleTextFormWidget(
              title: "비밀번호 확인",
              hintText: "비밀번호 재입력",
              obSecure: true,
              controller: _pwValidController,
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Material(
        color: bottomButtonColor,
        child: InkWell(
          onTap: () {
            if (!isReadyToRegister()) {
              return;
            }
            authenticateService
                .doRegister(_emailController.text, _pwController.text)
                .then((value) => userService.save(User(
                      uid: value.user!.uid,
                      email: _emailController.text,
                      phoneNumber: args.phoneNumber,
                      username: args.username,
                    )))
                .then((value) => showSuccessModal());
          },
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                '입력 완료',
                style: bottomButtomTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSuccessModal() {
    //style 정의
    TextStyle welcomeTextStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );

    TextStyle horizonTextStyle = const TextStyle(
      fontSize: 40,
      color: Color(0xffc5c8ce),
    );

    TextStyle infoTextStyle = const TextStyle(
      color: Color(0xff6f7985),
    );

    BoxDecoration bottomButtonStyle = BoxDecoration(
      border: Border.all(
        color: const Color(0xffe9ebee),
      ),
    );

    TextStyle bottomButtonTextStyle = const TextStyle(
      fontSize: 15,
      color: Color(0xff00b8ff),
    );

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
                      Text(
                        "쏘카 가입을 환영합니다!",
                        style: welcomeTextStyle,
                      ),
                      const SizedBox(height: 5),
                      const Text("쏘카의 다양한 서비스를 지금 바로 이용해보세요."),
                      Text(
                        "-",
                        style: horizonTextStyle,
                      ),
                      Text(
                        "(주)쏘카",
                        style: infoTextStyle,
                      ),
                      Text(
                        "회원님이 ${today.year}년 ${today.month}월 ${today.day}일에 요청하신 마케팅 정보 수신동의는 문자메시지, 이메일, 푸시메시지 쿠폰/혜택 알림 미동의 처리되었습니다.",
                        style: infoTextStyle,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 50,
                  decoration: bottomButtonStyle,
                  child: Center(
                    child: TextButton(
                      onPressed: toMainPage,
                      child: Text(
                        "서비스 둘러보기",
                        style: bottomButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void toMainPage() {
    // 회원가입과 동시에 로그인 수행
    authenticateService.doLogin(_emailController.text, _pwController.text);
    Navigator.pushNamed(context, "/main");
  }

  bool isReadyToRegister() {
    return UserInputValidator.validEmailAndPasswordFormat(
            _emailController.text, _pwController.text) &&
        _pwController.text == _pwValidController.text;
  }
}

class InputPageArguments {
  final String username;
  final String phoneNumber;
  InputPageArguments({required this.username, required this.phoneNumber});
}
