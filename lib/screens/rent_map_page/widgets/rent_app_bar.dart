import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';

class RentAppBar extends StatelessWidget implements PreferredSizeWidget {
  String titleText;

  RentAppBar({
    super.key,
    this.titleText = "쏘카",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: ColorPalette.gray500),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: const Color(0xff374553),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.white,
      elevation: 1.0,
      title: Text(
        titleText,
      ),
      titleTextStyle: const TextStyle(
        color: ColorPalette.gray600,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
