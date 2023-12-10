import 'package:flutter/material.dart';

import 'package:socar/constants/color.dart';
import 'package:socar/models/socar_zone.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/icon_row.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/text_styles.dart';
import 'package:socar/screens/rent_map_page/widgets/padding_box.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({Key? key, required this.socarZone}) : super(key: key);

  final SocarZone socarZone;

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.all(10),
            child: Text(socarZone.elevationType),
          ),
          Text(
            socarZone.name,
            style: parkingNameStyle,
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
                          icon: const Icon(Icons.exit_to_app),
                        )
                      ]),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Text(
                                  socarZone.name,
                                  style: parkingNameStyle,
                                ),
                                const PaddingBox(
                                  width: 15,
                                  height: 0,
                                ),
                                Text(
                                  socarZone.name,
                                  style: socarGray300Style,
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
                                  image: NetworkImage(socarZone.imgSrc),
                                  fit: BoxFit.cover),
                            ),
                            child: const PaddingBox(
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                      IconRowWidget(
                          icon: Icons.fmd_good_sharp, text: socarZone.address),
                      IconRowWidget(
                          icon: Icons.drive_eta, text: socarZone.spot),
                      IconRowWidget(
                          icon: Icons.access_time_filled_sharp,
                          text: "${socarZone.serviceHours}시간")
                    ]),
                  );
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                "자세히",
                style: socarGray500Style,
              ),
            ),
          )
        ],
      ),
    );
  }
}
