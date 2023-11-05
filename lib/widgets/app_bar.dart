import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String titleText;

  CustomAppBar({
    super.key,
    this.titleText = "",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const IconButton(
        icon: Icon(Icons.arrow_back),
        color: Color(0xff374553),
        onPressed: null,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(
        titleText,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
