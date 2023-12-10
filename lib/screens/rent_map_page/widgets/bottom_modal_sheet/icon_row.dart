import 'package:flutter/material.dart';
import 'package:socar/constants/color.dart';
import 'package:socar/screens/rent_map_page/widgets/padding_box.dart';

class IconRowWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  IconRowWidget({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color.fromARGB(255, 255, 255, 255), size: 16),
          const PaddingBox(width: 4, height: 0), // 간격을 조절하기 위한 SizedBox 추가
          Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
