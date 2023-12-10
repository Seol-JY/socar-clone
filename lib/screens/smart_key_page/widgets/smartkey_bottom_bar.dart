import 'package:flutter/material.dart';
import 'package:socar/constants/colors.dart';

class SmartkeyBottomBar extends StatelessWidget {
  final VoidCallback onDeleteRef;
  const SmartkeyBottomBar({Key? key, required this.onDeleteRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 150,
      padding: const EdgeInsets.only(bottom: 30),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: buildBottomBarContent(context),
      ),
    );
  }

  Widget buildBottomBarContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildSmartKeyStatus(),
        buildBottomBarButtons(context),
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

  Widget buildBottomBarButtons(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildReturnButton(context),
          buildLockButtons(),
        ],
      ),
    );
  }
Widget buildReturnButton(BuildContext context) {
  return Expanded(
    flex: 5,
    child: Center(
      child: Container(
        height: 70, // Adjust the height as needed
        child: TextButton(
          onPressed: () {
            // Call a function to show the dialog
            _showReturnDialog(context);
          },
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

void _showReturnDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("반납 확인"),
        content: Text("정말로 반납하시겠습니까?"),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text("취소"),
          ),
          TextButton(
            onPressed: () {
              onDeleteRef();
              Navigator.pushNamed(context, "/main");
            },
            child: Text("확인"),
          ),
        ],
      );
    },
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
