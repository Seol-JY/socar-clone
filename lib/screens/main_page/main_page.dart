import 'package:flutter/material.dart';
import 'package:socar/screens/main_page/widgets/go_to_get_car.dart';
import 'package:socar/screens/main_page/widgets/main_bar.dart';
import 'package:socar/screens/main_page/widgets/reservation_car.dart';
import 'package:socar/widgets/nav_drawer.dart';

class ReservationData {
  final String userName;
  final String carImageURL;
  final String carNumber;
  final DateTime reservationEndTime;
  final String parkingLocation;

  ReservationData({
    required this.userName,
    required this.carImageURL,
    required this.carNumber,
    required this.reservationEndTime,
    required this.parkingLocation,
  });
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var reservationData;

  @override
  void initState() {
    super.initState();
    // Simulate a delay of 3 seconds and then set the reservationData
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        reservationData = ReservationData(
          userName: "예약 구현 필요",
          carImageURL: "https://example.com/car_image.jpg",
          carNumber: "149허6166",
          reservationEndTime: DateTime(2023, 11, 26, 23, 10),
          parkingLocation: "아울렛주차장",
        );
      });
    });
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
        endDrawer: const NavDrawer(),
        appBar: MainBar(),
        bottomSheet: reservationData != null
            ? ReservationCar(reservationData: reservationData)
            : null,
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
      ),
    );
  }
}
