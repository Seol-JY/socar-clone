import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:socar/constants/colors.dart';
import 'package:socar/widgets/nav_drawer.dart';
import 'package:socar/widgets/rent_map_page/rent_app_bar.dart';
import 'package:socar/widgets/rent_map_page/time_select_btn.dart';

class RentMapPage extends StatelessWidget {
  const RentMapPage({super.key});

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
            body: NaverMap(
              options: const NaverMapViewOptions(
                scaleBarEnable: false,
              ),
              onMapReady: (controller) {},
            ),
            bottomSheet: const TimeSelectBtn()));
  }
}
