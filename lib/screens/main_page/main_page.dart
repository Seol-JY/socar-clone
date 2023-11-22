import 'package:flutter/material.dart';
import 'package:socar/screens/main_page/widgets/go_to_get_car.dart';
import 'package:socar/screens/main_page/widgets/main_bar.dart';
import 'package:socar/screens/main_page/widgets/reservation_car.dart';
import 'package:socar/widgets/nav_drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Color(0xfff2f4f6)),
            scaffoldBackgroundColor: const Color(0xfff2f4f6)),
        child: Scaffold(
          endDrawer: const NavDrawer(),
          appBar: MainBar(),
          // 예약 있으면 활성화할것
          bottomSheet: true ? const ReservationCar() : null,
          body: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GoToGetCarWidget(),
              ],
            ),
          ),
        ));
  }
}
