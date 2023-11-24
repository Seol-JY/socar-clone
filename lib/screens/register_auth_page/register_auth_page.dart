import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socar/screens/register_auth_page/utils/timerUtil.dart';
import 'package:socar/screens/register_auth_page/widgets/verify_code_input.dart';
import 'package:socar/screens/register_input_page/register_input_page.dart';
import 'package:socar/widgets/app_bar.dart';
import 'package:socar/widgets/term_agreement.dart';
import 'package:socar/screens/register_auth_page/widgets/dropdown_text_field_in_row.dart';
import 'package:socar/screens/register_auth_page/widgets/security_number_input.dart';

class RegisterAuthPage extends StatefulWidget {
  String selectedForeign = "내국인";
  String selectedAgency = "선택";

  RegisterAuthPage({super.key});

  @override
  State<RegisterAuthPage> createState() {
    return RegisterAuthPageState();
  }
}

class RegisterAuthPageState extends State<RegisterAuthPage> {
  bool isAuthCodeSended = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController authCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  TermAgreementBoxWidget termAgreementBoxWidget = TermAgreementBoxWidget();
  late TimerUtil timerUtil;

  @override
  void initState() {
    super.initState();

    timerUtil = TimerUtil(setWidgetState: () {
      setState(() {});
    });

    usernameController.addListener(() {
      setState(() {});
    });

    phoneNumberController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // style 정의
    TextStyle infoTextStyle = const TextStyle(
      fontSize: 18,
    );

    // lambda Function 정의
    setForeignDropdownValue(value) {
      widget.selectedForeign = value;
    }

    setAgencyDropdownValue(value) {
      widget.selectedAgency = value;
    }

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      appBar: CustomAppBar(
        titleText: "휴대폰 본인인증",
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                termAgreementBoxWidget,
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "이름",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownTextFieldInRowWidget(
                  selectedDropdown: widget.selectedForeign,
                  dropdownList: const ["내국인", "외국인"],
                  helperText: "본인 실명(통신사 가입 이름)",
                  setDropdownValue: setForeignDropdownValue,
                  textController: usernameController,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "주민등록번호 앞 7자리",
                  style: infoTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SecureNumberInputWidget(),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "휴대폰 정보",
                  style: infoTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownTextFieldInRowWidget(
                  selectedDropdown: widget.selectedAgency,
                  dropdownList: const ["선택", "SKT", "LG+", "KT", "알뜰폰"],
                  helperText: "휴대폰 번호 입력",
                  setDropdownValue: setAgencyDropdownValue,
                  inputFormatter: FilteringTextInputFormatter.digitsOnly,
                  textInputType: TextInputType.number,
                  textController: phoneNumberController,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: Color(0xffe9ebee),
                        ),
                        right: BorderSide(
                          color: Color(0xffe9ebee),
                        ),
                        bottom: BorderSide(
                          color: Color(0xffe9ebee),
                        ),
                      )),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: sendVerifyCode,
                          child: Text(
                            isAuthCodeSended ? "재전송" : "인증 번호 발송",
                            style: TextStyle(
                              color: isReadyToSendVerifyCode()
                                  ? const Color(0xff02b8ff)
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isAuthCodeSended,
                  child: VerifyCodeInput(
                    inputController: authCodeController,
                    timerText: timerUtil.getTimerText(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "· 본인 명의 휴대폰 번호만 인증이 가능합니다.",
                  style: TextStyle(color: Color(0xff646f7c)),
                ),
                const SizedBox(height: 5),
                const Text("· 휴대폰 본인인증은 나이스평가정보(주)에서 제공하는 서비스입니다.",
                    style: TextStyle(color: Color(0xff646f7c)))
              ],
            )),
      ),
      bottomNavigationBar: Material(
        color: isAuthCodeEntered()
            ? const Color(0xff00b8ff)
            : const Color(0xffe9ebee),
        child: InkWell(
          onTap: isAuthCodeEntered()
              ? () {
                  Navigator.pushNamed(context, "/register/input",
                      arguments: InputPageArguments(
                          username: usernameController.text));
                }
              : null,
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                '인증 완료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isAuthCodeEntered()
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

  bool isReadyToSendVerifyCode() {
    // 인증 코드를 전송하는 경우는 2가지가 존재함.
    // 1. 모든 Input을 채우고 인증번호 전송 버튼 클릭
    // 2. 인증번호 전송을 1회 이상 하고, 타이머가 0:00로 종료된 경우

    return ((!isAuthCodeSended) ||
            (isAuthCodeSended && timerUtil.isTimerDone())) &&
        termAgreementBoxWidget.isAllTermChecked &&
        phoneNumberController.text.length >= 11 &&
        usernameController.text.isNotEmpty;
  }

  void sendVerifyCode() {
    if (!isReadyToSendVerifyCode()) {
      return;
    }
    setState(() {
      isAuthCodeSended = true;
      timerUtil.runTimer();
    });
  }

  bool isAuthCodeEntered() {
    return authCodeController.text.length == 6;
  }
}
