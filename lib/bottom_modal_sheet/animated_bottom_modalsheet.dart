import 'package:flutter/material.dart';

import 'package:socar/bottom_modal_sheet/place_widget.dart';
import 'package:socar/bottom_modal_sheet/car_list_view.dart';
import 'package:socar/constants/color.dart';

import '../constants/fold_state_enum.dart';

class AnimatedBottomModalSheet extends StatelessWidget {
  const AnimatedBottomModalSheet({
    required this.screenHeight,
    required this.halfScreenHeight,
    Key? key,
    required this.fold,
    required this.getFoldState,
    required this.sheetState,
  }) : super(key: key);

  final void Function(bool) fold;
  final int Function() getFoldState;

  final double screenHeight;
  final double halfScreenHeight;
  final StateSetter sheetState;

  @override
  Widget build(BuildContext context) {
    int foldState = getFoldState();

    return AnimatedContainer(
      curve: Curves.easeInBack,
      duration: Duration(milliseconds: 600),
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: ColorPalette.gray500,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 10,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const PlaceWidget(),
          CarListView(),
        ],
      ),
    );
  }
}
