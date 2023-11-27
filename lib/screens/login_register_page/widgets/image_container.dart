import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 2, bottom: 1),
      child: Image.asset('assets/START_PAGE_IMG.png',
          width: double.maxFinite, height: 300, fit: BoxFit.fitWidth),
    );
  }
}
