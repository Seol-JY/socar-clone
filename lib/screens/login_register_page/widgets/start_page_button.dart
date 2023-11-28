import 'package:flutter/material.dart';

class StartPageButton extends StatelessWidget {
  int buttonBackgorundColor;
  String text;

  void Function()? onPressed;

  StartPageButton({
    super.key,
    required this.buttonBackgorundColor,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ButtonStyle textButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.resolveWith((state) {
        return const RoundedRectangleBorder(
          // 사각형 모양으로 설정
          borderRadius: BorderRadius.zero, // 모서리 반경을 0으로 설정
        );
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        return Color(buttonBackgorundColor);
      }),
    );

    Text textWidget = Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    );

    return TextButton(
      style: textButtonStyle,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: textWidget,
      ),
    );
  }
}
