import 'package:flutter/material.dart';
import 'package:socar/constants/color.dart';

class IconRowWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  IconRowWidget({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Icon(icon, color: ColorPalette.gray400),
          SizedBox(width: 10), // 간격을 조절하기 위한 SizedBox 추가
          Text(text)
        ],
      ),
    );
  }
}
