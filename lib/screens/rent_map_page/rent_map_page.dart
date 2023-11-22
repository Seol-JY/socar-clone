import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/widgets/nav_drawer.dart';
import 'package:socar/screens/rent_map_page/widgets/rent_app_bar.dart';
import 'package:socar/screens/rent_map_page/widgets/time_select_btn.dart';
import 'package:socar/constants/fold_state_enum.dart';
import 'package:socar/screens/rent_map_page/widgets/bottom_modal_sheet/animated_bottom_modalsheet.dart';

class RentMapPage extends StatefulWidget {
  const RentMapPage({super.key});

  @override
  _RentMapPageState createState() => _RentMapPageState();
}

class _RentMapPageState extends State<RentMapPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int foldState = FoldState.Fold.idx;

  void fold(bool isFold) {
    if (isFold) {
      foldState -= 1;

      if (foldState == FoldState.None.idx) {
        foldState = FoldState.Fold.idx;
        Navigator.pop(context);
        _controller.reverse();
      }
    }

    if (!isFold) {
      if (foldState < FoldState.Unfold.idx) {
        foldState += 1;
      }
    }
  }

  int getFoldState() {
    return foldState;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Colors.transparent),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: ColorPalette.white,
              elevation: 2,
            )),
        child: Scaffold(
            endDrawer: const NavDrawer(),
            appBar: RentAppBar(),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 55),
              child: FloatingActionButton.small(
                onPressed: () {},
                child: const Icon(Icons.my_location,
                    color: ColorPalette.gray600, size: 18),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            body: GestureDetector(
              onDoubleTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  enableDrag: false,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter sheetState) {
                        double screenHeight =
                            MediaQuery.of(context).size.height;
                        double halfScreenHeight = screenHeight / 2;

                        return AnimatedBottomModalSheet(
                          sheetState: sheetState,
                          fold: fold,
                          getFoldState: getFoldState,
                          screenHeight: screenHeight,
                          halfScreenHeight: halfScreenHeight,
                        );
                      },
                    );
                  },
                );
              },
              child: NaverMap(
                options: const NaverMapViewOptions(
                  scaleBarEnable: false,
                ),
                onMapReady: (controller) {},
              ),
            ),
            bottomSheet: const TimeSelectBtn()));
  }
}
