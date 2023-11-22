import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';

class SmartkeyBottomBar extends StatelessWidget {
  const SmartkeyBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 150,
      padding: const EdgeInsets.only(bottom: 30),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: buildBottomBarContent(),
      ),
    );
  }

  Widget buildBottomBarContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildSmartKeyStatus(),
        buildBottomBarButtons(),
      ],
    );
  }

  Widget buildSmartKeyStatus() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text("스마트키", style: TextStyle(color: ColorPalette.gray600, fontWeight: FontWeight.w700)),
          Text("OFF", style: TextStyle(color: ColorPalette.gray600, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget buildBottomBarButtons() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildReturnButton(),
          buildLockButtons(),
        ],
      ),
    );
  }

Widget buildReturnButton() {
  return Expanded(
    flex: 5,
    child: Center(
      child: Container(
        height: 70, // Adjust the height as needed
        child: TextButton(
          onPressed: () {},
          child: Text(
            "반납하기",
            style: TextStyle(color: ColorPalette.gray600, fontWeight: FontWeight.w700),
          ),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xffE9EBEE),
            padding: const EdgeInsets.symmetric(horizontal: 35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.withOpacity(0)),
            ),
          ),
        ),
      ),
    ),
  );
}


Widget buildLockButtons() {
  return Expanded(
    flex: 7,
    child: Container(
      height: 70, // Adjust the height to match the TextButton
      margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
      decoration: BoxDecoration(color: const Color(0xffE9EBEE), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton.outlined(onPressed: () {}, icon: const Icon(Icons.lock_outline)),
          IconButton.outlined(onPressed: () {}, icon: const Icon(Icons.lock_open)),
        ],
      ),
    ),
  );
}
}
