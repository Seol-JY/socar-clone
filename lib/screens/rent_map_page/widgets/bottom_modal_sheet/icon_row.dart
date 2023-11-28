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
        children: [
          Icon(icon, color: ColorPalette.gray400),
          const PaddingBox(width: 10, height: 0), // 간격을 조절하기 위한 SizedBox 추가
          Text(text)
        ],
      ),
    );
  }
}
