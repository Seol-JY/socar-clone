import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecureNumberInputWidget extends StatefulWidget {
  const SecureNumberInputWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SecureNumberInputState();
  }
}

class _SecureNumberInputState extends State<SecureNumberInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white, // 배경색을 흰색으로 설정
          border: Border.all(
            color: const Color(0xffe9ebee),
          ),
        ),
        child: const Row(
          children: [
            Expanded(
              flex: 10,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  border: InputBorder.none,
                  counterText: "",
                ),
                maxLength: 6,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                // 또는 Align 사용
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "-",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Color(0xffe9ebee),
                    ),
                  ),
                  readOnly: true,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    border: InputBorder.none,
                    counterText: ""),
                maxLength: 1,
              ),
            ),
            Expanded(
              flex: 8,
              child: Center(
                // 또는 Align 사용
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "******",
                    hintStyle: TextStyle(
                        fontSize: 20,
                        textBaseline: TextBaseline.ideographic,
                        letterSpacing: 10.0,
                        color: Color(0xffe9ebee)),
                  ),
                  readOnly: true,
                ),
              ),
            ),
          ],
        ));
  }
}
