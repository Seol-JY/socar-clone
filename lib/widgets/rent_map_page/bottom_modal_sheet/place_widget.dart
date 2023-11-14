import 'package:flutter/material.dart';

import 'package:socar/constants/color.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorPalette.gray300,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: EdgeInsets.all(10),
            child: Text("지상"),
          ),
          Text(
            "효성유료주차장",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              "자세히",
              style: TextStyle(
                color: ColorPalette.gray500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
