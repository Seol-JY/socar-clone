import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socar/widgets/app_bar.dart';
import 'package:socar/widgets/register_page/term_agreement.dart';
import 'package:socar/widgets/register_page/dropdown_text_field_in_row.dart';
import 'package:socar/widgets/register_page/security_number_input.dart';

class RegisterAuthPage extends StatefulWidget {
  const RegisterAuthPage({super.key});

  @override
  State<RegisterAuthPage> createState() {
    return RegisterAuthPageState();
  }
}

class RegisterAuthPageState extends State<RegisterAuthPage> {
  bool isAuthCompleted = false;
  bool isAuthStarted = false;

  @override
  Widget build(BuildContext context) {
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
                const TermAgreementBoxWidget(),
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
                  selectedDropdown: "내국인",
                  dropdownList: const ["내국인", "외국인"],
                  helperText: "본인 실명(통신사 가입 이름)",
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "주민등록번호 앞 7자리",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SecureNumberInputWidget(),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "휴대폰 정보",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownTextFieldInRowWidget(
                  selectedDropdown: "선택",
                  dropdownList: const ["선택", "SKT", "LG+", "KT", "알뜰폰"],
                  helperText: "휴대폰 번호 입력",
                  inputFormatter: FilteringTextInputFormatter.digitsOnly,
                  textInputType: TextInputType.number,
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
                          child: Text(isAuthStarted ? "재전송" : "인증 번호 발송"),
                          onPressed: () {
                            setState(() {
                              isAuthStarted = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isAuthStarted,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffe9ebee),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hoverColor: Colors.white,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color:
                                            Colors.grey), // placeholder 텍스트 스타일
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
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
        color:
            isAuthCompleted ? const Color(0xff00b8ff) : const Color(0xffe9ebee),
        child: InkWell(
          onTap: () {
            //print('called on tap');
          },
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                '인증 완료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:
                      isAuthCompleted ? Colors.white : const Color(0xffc5c8ce),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
