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
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  border: InputBorder.none,
                  counterText: "",
                ),
                maxLength: 6,
              ),
            ),
            const Expanded(
              flex: 1,
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "-",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey,
                    ),
                  ),
                  readOnly: true,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      border: InputBorder.none,
                      counterText: ""),
                  maxLength: 1,
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "******",
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        textBaseline: TextBaseline.ideographic,
                        letterSpacing: MediaQuery.of(context).size.width * 0.02,
                        color: Colors.grey),
                  ),
                  readOnly: true,
                ),
              ),
            ),
          ],
        ));
  }
}
