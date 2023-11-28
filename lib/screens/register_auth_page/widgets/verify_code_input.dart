import 'package:flutter/material.dart';
import 'package:socar/screens/register_auth_page/utils/timerUtil.dart';
import 'package:flutter/services.dart';

class VerifyCodeInput extends StatefulWidget {
  final TextEditingController inputController;
  final String timerText;

  const VerifyCodeInput(
      {super.key, required this.inputController, required this.timerText});

  @override
  State<StatefulWidget> createState() {
    return VerifyCodeInputState();
  }
}

class VerifyCodeInputState extends State<VerifyCodeInput> {
  @override
  void initState() {
    widget.inputController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    controller: widget.inputController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Colors.grey), // placeholder 텍스트 스타일
                    ),
                  )),
              Expanded(
                flex: 1,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    border: InputBorder.none,
                    hintText: widget.timerText,
                    hintStyle: const TextStyle(
                        color: Color(
                      0xffff2c51,
                    )), // placeholder 텍스트 스타일
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
