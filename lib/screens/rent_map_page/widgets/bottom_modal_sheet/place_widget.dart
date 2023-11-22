import 'package:flutter/material.dart';

import 'package:socar/constants/color.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/icon_row.dart';

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
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                useSafeArea: true,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.exit_to_app),
                        )
                      ]),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Text(
                                  "옥산유료주차장",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "인동서한이다음아파트 옆",
                                  style: TextStyle(
                                    color: ColorPalette.gray300,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/park.jpg'),
                                  fit: BoxFit.cover),
                            ),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                      IconRowWidget(
                          icon: Icons.fmd_good_sharp,
                          text: "경북 구미시 인의동 576-1 구미지게차 주차장"),
                      IconRowWidget(icon: Icons.drive_eta, text: "지상 1층"),
                      IconRowWidget(
                          icon: Icons.access_time_filled_sharp, text: "24시간")
                    ]),
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Text(
                "자세히",
                style: TextStyle(
                  color: ColorPalette.gray500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
