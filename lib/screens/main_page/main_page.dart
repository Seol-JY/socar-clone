import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socar/screens/main_page/widgets/go_to_get_car.dart';
import 'package:socar/screens/main_page/widgets/main_bar.dart';
import 'package:socar/screens/main_page/widgets/reservation_car.dart';
import 'package:socar/widgets/nav_drawer.dart';

class ReservationData {
  final String userName;
  final String carImageURL;
  final String carNumber;
  final DateTime reservationStartTime;
  final DateTime reservationEndTime;
  final String parkingLocation;
  DocumentReference? docRef;

  ReservationData({
    required this.userName,
    required this.carImageURL,
    required this.carNumber,
    required this.reservationStartTime,
    required this.reservationEndTime,
    required this.parkingLocation,
    this.docRef,
  });
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xfff2f4f6),
        ),
        scaffoldBackgroundColor: const Color(0xfff2f4f6),
      ),
      child: Scaffold(
          endDrawer: NavDrawer(),
          appBar: MainBar(),
          body: Stack(children: [
            const Padding(
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
            ReservationCar(),
          ])),
    );
  }
}
