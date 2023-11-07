import 'package:flutter/material.dart';

class TitleTextFormWidget extends StatefulWidget {
  String title;
  String hintText;
  bool obSecure;

  TitleTextFormWidget(
      {super.key,
      required this.title,
      required this.hintText,
      this.obSecure = false});

  @override
  State<StatefulWidget> createState() {
    return _TitleTextFormState();
  }
}

class _TitleTextFormState extends State<TitleTextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffe9ebee),
            ),
          ),
          child: TextField(
            obscureText: widget.obSecure,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hoverColor: Colors.white,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle:
                  const TextStyle(color: Colors.grey), // placeholder 텍스트 스타일
            ),
          ),
        )
      ],
    );
  }
}
