import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showTopSnackBar(BuildContext context, Widget content) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(15, 35, 15, 0),
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
            child: content,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
