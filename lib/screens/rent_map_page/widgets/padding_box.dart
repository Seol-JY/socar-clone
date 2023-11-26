import 'package:flutter/material.dart';

class PaddingBox extends StatelessWidget {
  const PaddingBox({
    Key? key,
    this.width = 0,
    this.height = 10,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
