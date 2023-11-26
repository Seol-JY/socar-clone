import 'package:flutter/material.dart';
import 'package:socar/services/user_auth_service.dart';

class SendCodeButton extends StatefulWidget {
  bool Function() isReadyToSendVerifyCode;
  UserAuthenticateService userAuthService;
  bool isAuthCodeSended;
  SendCodeButton(
      {super.key,
      required this.isReadyToSendVerifyCode,
      required this.userAuthService,
      required this.isAuthCodeSended});

  @override
  State<StatefulWidget> createState() {
    return SendCodeButtonState();
  }
}

class SendCodeButtonState extends State<SendCodeButton> {
  @override
  Widget build(BuildContext context) {
    BoxDecoration sendCodeButtonDecoration = const BoxDecoration(
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
        ));

    return Container(
      decoration: sendCodeButtonDecoration,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                if (!widget.isReadyToSendVerifyCode()) {
                  return;
                }

                widget.userAuthService.sendVerifyCode();
                setState(() {
                  widget.isAuthCodeSended = true;
                });
              },
              child: Text(
                widget.isAuthCodeSended ? "재전송" : "인증 번호 발송",
                style: TextStyle(
                  color: widget.isReadyToSendVerifyCode()
                      ? const Color(0xff02b8ff)
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
