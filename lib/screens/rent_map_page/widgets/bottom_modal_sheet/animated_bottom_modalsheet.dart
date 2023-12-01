import 'package:flutter/material.dart';
import 'package:socar/models/socar_zone.dart';

import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/place_widget.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/car_list_view.dart';
import 'package:socar/constants/color.dart';
import 'package:socar/screens/rent_map_page/widgets/padding_box.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/swipe_bar.dart';

import 'package:socar/car_data/car_data.dart';

import '../../../../constants/fold_state_enum.dart';

class AnimatedBottomModalSheet extends StatelessWidget {
  const AnimatedBottomModalSheet({
    required this.screenHeight,
    required this.halfScreenHeight,
    Key? key,
    required this.fold,
    required this.getFoldState,
    required this.sheetState,
    required this.socarZone,
  }) : super(key: key);

  final void Function(bool) fold;
  final int Function() getFoldState;

  final double screenHeight;
  final double halfScreenHeight;
  final StateSetter sheetState;
  final SocarZone socarZone;

  @override
  Widget build(BuildContext context) {
    int foldState = getFoldState();

    return AnimatedContainer(
      curve: Curves.easeInBack,
      duration: const Duration(milliseconds: 600),
      height: foldState == FoldState.Fold.idx ? halfScreenHeight : screenHeight,
      color: ColorPalette.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onVerticalDragEnd: (details) {
              sheetState(() {
                // swipe-down
                if (details.primaryVelocity! > 0) {
                  fold(true);
                }
                // swipe-up
                if (details.primaryVelocity! < 0) {
                  fold(false);
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const Column(
                children: [
                  PaddingBox(),
                  Swipebar(),
                  PaddingBox(),
                ],
              ),
            ),
          ),
          const PlaceWidget(),
          FutureBuilder<List<CarData>>(
            future: getCarDataBySocarZoneId(
                socarZone.id), // 비동기 함수를 호출하여 Future를 얻습니다.
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('에러: ${snapshot.error}');
              } else {
                List<CarData> carDataList = snapshot.data ?? [];
                return CarListView(carList: carDataList);
              }
            },
          )
        ],
      ),
    );
  }
}
