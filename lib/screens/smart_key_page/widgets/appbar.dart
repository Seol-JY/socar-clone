import 'package:flutter/material.dart';
import 'package:socar/constants/color.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: ColorPalette.gray600,
    elevation: 0.0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.arrow_back_sharp),
        onPressed: () {
          Navigator.pushNamed(context, "/main");
        },
      ),
    ),
  );
}
