import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';

class MarinBar extends StatelessWidget implements PreferredSizeWidget {
  String titleText;

  MarinBar({
    super.key,
    this.titleText = "",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        "assets/MAIN_HEADER_LOGO.png",
        width: 90,
      ),
      backgroundColor: const Color(0xfff2f4f6),
      elevation: 0.0,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          color: ColorPalette.gray400,
          iconSize: 30,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
