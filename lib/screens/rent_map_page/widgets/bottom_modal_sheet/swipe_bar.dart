import 'package:flutter/material.dart';

import 'package:socar/constants/color.dart';

class Swipebar extends StatelessWidget {
  const Swipebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: ColorPalette.gray500,
        width: MediaQuery.of(context).size.width * 0.4,
        height: 10,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
